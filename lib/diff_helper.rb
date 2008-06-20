module DiffHelper
  protected
  # generates a simple line diff
  def line_diff(old, new)
    RailsDiff.line_diff(old,new)
  end
  
  
  def correction_diff(old, new)
    RailsDiff.correction_diff(old, new, Output::SimpleCorrectionDiff)
  end
  
end
