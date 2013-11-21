module TinyRafine
  module NilClass

    refine ::NilClass do
      def method_missing(method_name, *args)
        nil
      end

      # Define a redirection from implicit to explicit conversion for Integer, String, Array and Hash
      ['int', 'str', 'ary', 'hash'].each do |method| #FIXMEFAIL
        define_method "to_#{method[0]}" do
          Rails.logger.error "send to_#{method}"
          res = send "to_#{method}"
          Rails.logger.error "res : #{res}"
          res
        end
      end
    end

  end
end

