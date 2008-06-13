begin
  require 'rubygems'
  require 'diff/lcs'
  require 'diff/lcs/string'
  require 'text/format'
rescue
  raise "You need to have RubyGems (http://www.rubygems.org/) and ... installed"
end

class RailsDiff
  def self.diff(old, new)
    hd = RailsDiff::HtmlDiff.new
    tf = Text::Format.new
    tf.tabstop = 2
    preprocess = lambda { |line| tf.expand(line.chomp) }
    
    a = old.split(/\n|\r\n/)
    b = new.split(/\n|\r\n/)
    
    a.map(&preprocess)
    b.map(&preprocess)
    Diff::LCS.traverse_balanced(a, b, hd)
#    Diff::LCS.traverse_sequences(a, b, hd)
    hd.custom
  end
end

class RailsDiff::HtmlDiff #:nodoc:
  attr_accessor :custom
  attr_accessor :old
  attr_accessor :new

  def initialize
    @custom = ""
    @old = 1
    @new = 1
  end
    
  def change(event)
    @custom << %Q|<tr><td>#{old}. </td><td><pre class="only_a">#{event.old_element}</pre></td><td><pre class="only_b">#{event.new_element}</pre></td><td>#{new}. </td></tr>\n|
    @old += 1
    @new += 1
  end

    # This will be called with both lines are the same
  def match(event)
    @custom << %Q|<tr><td>#{old}. </td><td colspan="2"><pre class="match">#{event.old_element}</pre>\n</td><td>#{new}. </td></tr>|
    @old += 1
    @new += 1
  end

    # This will be called when there is a line in A that isn't in B
  def discard_a(event)
    @custom << %Q|<tr><td>#{old}. </td><td><pre class="only_a">#{event.old_element}</pre></td><td></td><td></td></tr>\n|
    @old += 1
  end

    # This will be called when there is a line in B that isn't in A
  def discard_b(event)
    @custom << %Q|<tr><td></td><td></td><td><pre class="only_b">#{event.new_element}</pre></td><td>#{new}. </td></tr>\n|
    @new += 1
  end
end
