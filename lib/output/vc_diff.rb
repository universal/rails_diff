class Output::VcDiff #:nodoc:
  attr_accessor :content
  attr_accessor :old_line
  attr_accessor :new_line
  attr_accessor :last_lines
  attr_accessor :last

  def initialize
    @content = ""
    @last_lines = []
    @old_line = 1
    @new_line = 1
  end
    
  def change(event)
    add_last_lines unless @last == :change
    @content << %Q|<tr><td>#{old_line}. </td><td><pre class="only_a">#{event.old_element}</pre></td><td><pre class="only_b">#{event.new_element}</pre></td><td>#{new_line}. </td></tr>\n|
    
    @last = :change
    @old_line += 1
    @new_line += 1
  end

    # This will be called with both lines are the same
  def match(event)
    @last_lines.push %Q|<tr><td>#{old_line}. </td><td colspan="2"><pre class="match">#{event.old_element}</pre></td><td>#{new_line}. </td></tr>\n|
    @old_line += 1
    @new_line += 1
  end

    # This will be called when there is a line in A that isn't in B
  def discard_a(event)
    add_last_lines unless @last == :discard_a
    @content << %Q|<tr><td>#{old_line}. </td><td><pre class="only_a">#{event.old_element}</pre></td><td></td><td></td></tr>\n|

    @last = :discard_a    
    @old_line += 1
  end

    # This will be called when there is a line in B that isn't in A
  def discard_b(event)
    add_last_lines unless @last == :discard_b
    @content << %Q|<tr><td></td><td></td><td><pre class="only_b">#{event.new_element}</pre></td><td>#{new_line}. </td></tr>\n|
    
    @last = :discard_b
    @new_line += 1
  end
  
  def add_last_lines(n = 3)
    @content << %Q|<tr><td colspan="4">Next Change: </td></tr>\n|
    start = @last_lines.length - n
    start = 0 if start < 0
    start.upto @last_lines.length do |i|
      @content << @last_lines[i] if @last_lines[i]
    end
    @last_lines = []
  end
  
end
