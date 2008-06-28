require 'action_view/template_handlers/erb'
class RailsDiff
  # add html_escape to class level ;)
  extend ERB::Util
  def self.diff(old, new, output = Output::SimpleHtmlDiff)
    # html_escape code for display and split strings into lines array
    a = html_escape(old).split(/\015?\012/)
    b = html_escape(new).split(/\015?\012/)
    #remove trailing.. whitespace
    #a.map{|c| c.strip!}
    #b.map{|c| c.strip!}
    out = output.new
    Diff::LCS.traverse_balanced(a, b, out)
    out.content
  end
end
