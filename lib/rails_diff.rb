require 'action_view/template_handlers/erb'
class RailsDiff
  # add html_escape to class level ;)
  extend ERB::Util
  def self.line_diff(old, new, output = Output::SimpleHtmlDiff)
    # split strings into lines array
    a = html_escape(old).split(/\015?\012/)
    b = html_escape(new).split(/\015?\012/)
    #remove trailing.. whitespace
    #a.map{|c| c.strip!}
    #b.map{|c| c.strip!}
    out = output.new
    Diff::LCS.traverse_balanced(a, b, out)
    out.content
  end
  
  def self.correction_diff(old, new, output = Output::SimpleCorrectionDiff)
    a = html_escape(old).split(/\015?\012/)
    b = html_escape(new).split(/\015?\012/)
    out = output.new
    Diff::LCS.traverse_balanced(a, b, out)
    out.content
  end
  
end
