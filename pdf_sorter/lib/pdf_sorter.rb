#!/usr/bin/env ruby
require 'directory_watcher'
require 'docsplit'

require_relative 'pdf_sorter/rule_set'
require_relative 'pdf_sorter/doc_path'


class PdfSorter

  attr_accessor :ruleset

  def initialize(ruleset)
    @ruleset = ruleset
    @dw = DirectoryWatcher.new '/Users/najlen/docSync/projekt/PDF sorter/inbox', :glob => '*.pdf'
    @dw.interval = 5.0
    @dw.stable = 2
    @dw.start
    @dw.add_observer(self)
    @@instance = self
  end
  
  def self.instance
    @@instance
  end

  def update(event)
    handle_event DocPath.new(event.path) if event.type == :stable
  end
  
  def add_rule(rule)
    @ruleset.rules << rule
  end
  
  def stop
    @dw.stop
  end
  
  private
  
  def handle_event(path)
    exctract_text path
    compare_and_move_file path
  end
  
  def exctract_text(path)
    #Extract text to file, saves to file.
    Docsplit.extract_text(path.pdf, :ocr => false, :output => path.textdir )
  end


  def get_file_contents(path)
    f = File.open(path.text, "r")
    fs = f.read
    f.close
    #FileUtils.rm(path.text)
    fs
  end
  
  def compare_and_move_file(path)
  
    fs = get_file_contents(path)
    match = false
    
    @ruleset.rules.each do |rule|
      puts "Now running rule: #{p rule}"
      rule.m_strings.each do |searchstring|
        puts "Looking for string: #{searchstring}" 
        if fs.include? searchstring
          match = true
          break
        end
      end
      if match
        puts "Got match with rule #{rule} - target folder #{rule.t_folder}"
        #move according to rule
        FileUtils.mkdir_p path.targetdir(rule)
        FileUtils.mv(path.pdf, path.targetfile(rule))
        break
      end
    end
  end
end


