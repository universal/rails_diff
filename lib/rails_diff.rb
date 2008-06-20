class RailsDiff
  def self.line_diff(old, new, output = Output::SimpleHtmlDiff)
    # split strings into lines array
    a = old.split(/\n|\r\n/)
    b = new.split(/\n|\r\n/)
    #remove trailing.. whitespace
    #a.map{|c| c.strip!}
    #b.map{|c| c.strip!}
    out = output.new
    Diff::LCS.traverse_balanced(a, b, out)
    out.content
  end
  
  def self.correction_diff(old, new, output = OutputSimpleCorrectionDiff)
    a = old.split(/\n|\r\n/)
    b = new.split(/\n|\r\n/)
    out = output.new
    Diff::LCS.traverse_balanced(a, b, out)
    out.content
  end
  
end
