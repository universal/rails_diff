require 'action_view/template_handlers/erb'
class Output::StringSimpleCorrectionDiff #:nodoc:
  
  attr_accessor :content, :last, :closing

  def initialize
    @content = ""
    
  end
    
  def change(event)
    if @last.nil?
      @content << %Q|<span class="change">|
    elsif @last != :change
      @content << %Q|#{closing}</span><span class="change">|    
    end
    @content << %Q|<del class="only_a">#{event.old_element}</del><ins class="only_b">#{event.new_element.to_s}</ins>|
    @last = :change
    @closing = ""
  end

    # This will be called with both lines are the same
  def match(event)
    if @last.nil?
      @content << %Q|<span class="match">|
    elsif @last != :match
      @content << %Q|#{closing}</span><span class="match">|
    end
    @content << event.old_element.to_s
    @last = :match
    @closing = ""
  end

    # This will be called when there is a line in A that isn't in B
  def discard_a(event)
    if @last.nil?
      @content << %Q|<span class="only_a"><del>|
    elsif @last != :only_a
      @content << %Q|#{closing}</span><span class="only_a"><del>|
    end
    @content << %Q|#{event.old_element.to_s}|
    @last = :only_a
    @closing = "</del>"
  end

    # This will be called when there is a line in B that isn't in A
  def discard_b(event)
    if @last.nil?
      @content << %Q|<span class="only_b"><ins>|
    elsif @last != :only_b
      @content << %Q|#{closing}</span><span class="only_b"><ins>|
    end
    @content << %Q|#{event.new_element.to_s}|
    @last = :only_b
    @closing = "</ins>"
  end
end
