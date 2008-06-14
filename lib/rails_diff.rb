class RailsDiff
  def self.diff(old, new, output = Output::SimpleHtmlDiff)
    out = output.new
    
    # split strings into lines array
    a = old.split(/\n|\r\n/)
    b = new.split(/\n|\r\n/)
    #remove trailing.. whitespace
    #a.map{|c| c.strip!}
    #b.map{|c| c.strip!}
    
    Diff::LCS.traverse_balanced(a, b, out)
    out.content
  end
end
