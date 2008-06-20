require 'action_view/template_handlers/erb'
class Output::SimpleCorrectionDiff #:nodoc:
  include ERB::Util

  attr_accessor :content

  def initialize
    @content = ""
  end
    
  def change(event)
    @content << %Q|<pre class="change">#{html_escape(event.new_element)}</pre><br/>\n|
  end

    # This will be called with both lines are the same
  def match(event)
    @content << %Q|<pre class="match">#{html_escape(event.new_element)}</pre><br/>\n|
  end

    # This will be called when there is a line in A that isn't in B
  def discard_a(event)
    @content << %Q|<pre class="only_a"><del>#{html_escape(event.new_element)}</del></pre><br/>\n|
  end

    # This will be called when there is a line in B that isn't in A
  def discard_b(event)
    @content << %Q|<pre class="only_b"><ins>#{html_escape(event.new_element)}</ins></pre><br/>\n|
  end
end
