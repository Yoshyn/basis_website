# PublicController is the main class of public controller.
# The publics controllers into public folder are load by config/application.rb

class PublicController < ApplicationController
  # Append the view path to app/view/public cause we don't use namespace but we want a special folder for public view
  # The public controller are load by config/application.rb.
  append_view_path 'app/views/public'

  layout 'public'
end
