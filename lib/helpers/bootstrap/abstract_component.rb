module BootstrapHelper

  class AbstractComponent  < Struct.new(:view, :callback)
    include TinyMethods

    def initialize(view, *args, &block)
      raise "Trying to instantiate abstract class for #{self.class}" if abstract_class?
      super(*[view, block])
      manage_args(*args)
      instance_exec(self, &callback)
    end

    def manage_args(*args)
    end

    def render
      raise "Trying to call abstract method for #{self}"
    end

  private

    def method_missing(method, *args, &block)
      view.send(method, *args, &block)
    end

    def abstract_class?
      self.class == AbstractComponent
    end
  end

end