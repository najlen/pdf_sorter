#!/usr/bin/env ruby
require 'directory_watcher'
require 'docsplit'

class Rule
  attr_accessor :strings, :target_folder, :name
  
  def to_s
    @name
  end
  
end

class DocPath
  attr_accessor :text, :pdf, :textdir
  
  def initialize(path)

    @pdf = path
    @text = "#{File.dirname(path)}/ocrtext/#{File.basename(path, ".pdf")}.txt"
    @textdir = "#{File.dirname(path)}/ocrtext/"

  end

  def to_s
    "DocPath text_path: #{@text}, pdf_path: #{@pdf}"
  end

end


dw = DirectoryWatcher.new '/Users/najlen/docSync/projekt/PDF sorter/inbox', :glob => '*.pdf'
dw.interval = 5.0
dw.stable = 2


def handle_file(path)
  exctract_text path
  match_file path
end

def exctract_text(path)

  #Extract text to file
  Docsplit.extract_text(path.pdf, :ocr => false, :output => path.textdir )
  
end

def match_file(path)
  rule1 = Rule.new
  rule1.name = "Skattepapper"
  rule1.strings = ["fskatt", "Skatteverket","rsv"]
  rule1.target_folder = "skattepapper"
  
  rule2 = Rule.new
  rule2.name = "Sbab"
  rule2.strings = ["fskatt","bolån","ränta"]
  rule2.target_folder = "huslån"
  
  rules = []
  rules << rule1
  rules << rule2
  
  f = File.open(path.text, "r")
  fs = f.read
  
  match = false
  rules.each do |rule|
    puts "Now running rule: #{rule.name}"
    rule.strings.each do |searchstring|
      puts "Looking for string: #{searchstring}" 
      if fs.include? searchstring
        match = true
        break
      end
    end
    if match
      puts "Got mach with rule #{rule} - target folder #{rule.target_folder}"
      break
    end
  end
  f.close
end

dw.add_observer do |*args| 
  args.each do |event| puts event
    if event.type == :stable
      puts "We got stable #{event.path}"
      path = DocPath.new event.path
      handle_file path 
    end
  end
end


dw.start
gets      # when the user hits "enter" the script will terminate
dw.stop
