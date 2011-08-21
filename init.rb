config.gem "diff-lcs", :lib => "diff/lcs"
require 'erubis'
require 'rails_diff'
config.after_initialize do
  # Include our helper into every view
  ActionView::Base.send :include, DiffHelper
end

