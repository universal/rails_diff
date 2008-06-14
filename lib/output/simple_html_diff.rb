class Output::SimpleHtmlDiff #:nodoc:
  attr_accessor :content
  attr_accessor :old
  attr_accessor :new

  def initialize
    @content = ""
    @old = 1
    @new = 1
  end
    
  def change(event)
    @content << %Q|<tr><td>#{old}. </td><td><pre class="only_a">#{event.old_element}</pre></td><td><pre class="only_b">#{event.new_element}</pre></td><td>#{new}. </td></tr>\n|
    @old += 1
    @new += 1
  end

    # This will be called with both lines are the same
  def match(event)
    @content << %Q|<tr><td>#{old}. </td><td colspan="2"><pre class="match">#{event.old_element}</pre></td><td>#{new}. </td></tr>\n|
    @old += 1
    @new += 1
  end

    # This will be called when there is a line in A that isn't in B
  def discard_a(event)
    @content << %Q|<tr><td>#{old}. </td><td><pre class="only_a">#{event.old_element}</pre></td><td></td><td></td></tr>\n|
    @old += 1
  end

    # This will be called when there is a line in B that isn't in A
  def discard_b(event)
    @content << %Q|<tr><td></td><td></td><td><pre class="only_b">#{event.new_element}</pre></td><td>#{new}. </td></tr>\n|
    @new += 1
  end
end
