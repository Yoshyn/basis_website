module BootstrapHelper

  # AbstractComponent is the parrent class to manage the bootstrap component (dropdown, tab...).
  # It s an abstract class who manage the view and the block.
  # You have to rewrite are the following methods :
  # * render (require).
  # * manage_args (optionnal).
  #
  # Notice that manage args is call by the initialize method. When you extend AbstractComponent,
  # do not override the initialize method, ue manage_args instead.
  class AbstractComponent  < Struct.new(:view, :callback)
    include TinyMethods

    # Manage the context (view) and the block
    def initialize(view, *args, &block)
      raise "Trying to instantiate abstract class for #{self.class}" if abstract_class?
      super(*[view, block])
      manage_args(*args)
      instance_exec(self, &callback)
    end

protected

    # Call by initialize.
    # Override this methods if you want to perform action during initialisation of your component
    def manage_args(*args)
    end

  private

    def abstract_class?
      self.class == AbstractComponent
    end

    # Redirect all missing method to the view.
    # It's usefull for all helper view like, for exemple link_to.
    def method_missing(method, *args, &block)
      view.send(method, *args, &block)
    end

    # Render the component in html
    def render
      raise "Trying to call abstract method for #{self}"
    end
  end

end