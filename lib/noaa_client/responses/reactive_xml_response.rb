module NoaaClient
  module Responses
    module ReactiveXmlResponse
      def method_missing(method_name, *arguments, &block)
        if tag = source.css(method_name.to_s)
          if block
            block.call tag.text
          else
            tag.text
          end
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        source.css(method_name.to_s) || super
      end

      def source
        @source || NullResponse.new
      end

      class NullResponse
        def css(*args); end
      end
    end
  end
end
