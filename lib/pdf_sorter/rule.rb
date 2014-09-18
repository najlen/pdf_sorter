require_relative '../pdf_sorter'
class Rule
  attr_accessor :m_strings, :t_folder, :name
  
  def initialize(name)
    @name = name
    PdfSorter.instance.add_rule(self)
  end
  
  def match_strings(strings)
    @m_strings = strings.split(",")
  end
  
  def target_folder(target_folder)
    @t_folder = target_folder
  end

  def to_s
    "#{@name}, #{@t_folder}, #{@m_strings}"
  end
  
end