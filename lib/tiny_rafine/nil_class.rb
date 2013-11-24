module TinyRafine

  raise "TinyRafine module is designed to be include in Rails context. It's seem that Rails is not defined." unless defined?(Rails)

  # This module refine NilClass. The purpose of this refine is to avoid error like :
  # Undefined method for nil class.
  module NilClass

    refine ::NilClass do
      # A method missing on nil will always return nil
      def method_missing(method_name, *args)
        self
      end
    end
  end
end