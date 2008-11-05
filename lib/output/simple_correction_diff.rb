require 'action_view/template_handlers/erb'
class Output::SimpleCorrectionDiff #:nodoc:
  include ERB::Util

  attr_accessor :content

  def initialize
    @content = ""
  end
    
  def change(event)
    out = Output::StringSimpleCorrectionDiff.new
    Diff::LCS.traverse_sequences(event.old_element, event.new_element, out)
    @content << %Q|<span class="change">#{out.content}#{out.closing}</span><br/></span><br/>\n|
  end

    # This will be called with both lines are the same
  def match(event)
    @content << %Q|<span class="match">#{event.new_element}</span><br/>\n|
  end

    # This will be called when there is a line in A that isn't in B
  def discard_a(event)
    @content << %Q|<span class="only_a"><del>#{event.old_element}</del></span><br/>\n|
  end

    # This will be called when there is a line in B that isn't in A
  def discard_b(event)
    @content << %Q|<span class="only_b"><ins>#{event.new_element}</ins></span><br/>\n|
  end
end
