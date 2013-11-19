# Theses helpers are under lib folder
require 'helpers/bootstrap/bootstrap_helper'
require 'helpers/fontawesome/fontawesome_helper'

module ApplicationHelper
  include BootstrapHelper
  include FontawsomeHelper

  # Renders an icon from bootstrap or fontawsome
  #
  # Example :
  # = icon 'exclamation-sign', lib: 'bs'
  # = icon :linux, border: true, rotate: 90
  #
  # Arguments :
  # * +name+    :  The +name+ of the icon. In bootstrap or font-awsome for exemple.
  # See other arguments on
  # -> bootstrap/bootstrap_helper#BootstrapHelper@bsh_icon
  # -> bootstrap/fontawesome_helper#FontawsomeHelper@fah_icon
  def icon(name, *args)
    opts = args.extract_options!.symbolize_keys.delete_if { |_, v| v.blank? }
    if (lib = opts.delete(:lib)) && lib.to_sym == :bs
      bsh_icon(name, *[opts])
    else
      fah_icon(name, *[opts])
    end
  end

  # Neested Layout. See :
  # http://m.onkey.org/nested-layouts-in-rails-3
  def inside_layout(parent_layout)
    view_flow.set :layout, capture { yield }
    render template: "layouts/#{parent_layout}"
  end
end
