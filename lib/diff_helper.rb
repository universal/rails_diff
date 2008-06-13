module DiffHelper
  protected
  def diff(old, new)
    RailsDiff.diff(old, new)
  end
end
