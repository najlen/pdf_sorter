class DocPath
  attr_accessor :text, :pdf, :textdir
  
  def initialize(path)

    @pdf = path
    @pdffilename = File.basename(path)
    @pdfdir = File.dirname(path)
    @text = "#{File.dirname(path)}/#{File.basename(path, ".pdf")}.txt"
    @textdir = "#{File.dirname(path)}/"

  end
  
  def targetdir(rule)
      "#{@pdfdir}/#{rule.t_folder}/"
  end
  
  def targetfile(rule)
    "#{@pdfdir}/#{rule.t_folder}/#{@pdffilename}"
  end

  def to_s
    "DocPath text_path: #{@text}, pdf_path: #{@pdf}"
  end
  
end