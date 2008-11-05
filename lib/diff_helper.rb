module DiffHelper
  protected
  # generates a simple line diff
  def line_diff(old, new)
    RailsDiff.diff(old,new)
  end
  
  # generates a simple correction diff with "inline-diffs"
  def correction_diff(old, new)
    RailsDiff.diff(old, new, Output::SimpleCorrectionDiff)
  end
  
  # generates a simple vc similar diff, where only the changes + some preceding 
  # lines are shown
  def vc_diff(old,new)
    RailsDiff.diff(old,new, Output::VcDiff)
  end
end
