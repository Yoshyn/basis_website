module TinyRafine
  module NilClass

    refine ::NilClass do
      def method_missing(method_name, *args)
        self
      end
    end
  end
end

