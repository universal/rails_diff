require 'action_view/template_handlers/erb'
class Output::SimpleHtmlDiff #:nodoc:
  include ERB::Util

  attr_accessor :content
  attr_accessor :old_line
  attr_accessor :new_line

  def initialize
    @content = ""
    @old_line = 1
    @new_line = 1
  end
    
  def change(event)
    @content << %Q|<tr><td>#{old_line}. </td><td><pre class="only_a">#{html_escape(event.old_element)}</pre></td><td><pre class="only_b">#{html_escape(event.new_element)}</pre></td><td>#{new_line}. </td></tr>\n|
    @old_line += 1
    @new_line += 1
  end

    # This will be called with both lines are the same
  def match(event)
    @content << %Q|<tr><td>#{old_line}. </td><td colspan="2"><pre class="match">#{html_escape(event.old_element)}</pre></td><td>#{new_line}. </td></tr>\n|
    @old_line += 1
    @new_line += 1
  end

    # This will be called when there is a line in A that isn't in B
  def discard_a(event)
    @content << %Q|<tr><td>#{old_line}. </td><td><pre class="only_a">#{html_escape(event.old_element)}</pre></td><td></td><td></td></tr>\n|
    @old_line += 1
  end

    # This will be called when there is a line in B that isn't in A
  def discard_b(event)
    @content << %Q|<tr><td></td><td></td><td><pre class="only_b">#{html_escape(event.new_element)}</pre></td><td>#{new_line}. </td></tr>\n|
    @new_line += 1
  end
end
