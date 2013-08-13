module NoaaClient
  module Responses
    module ReactiveResponse
      def method_missing(method_name, *arguments, &block)
        if tag = source.css(method_name.to_s)
          tag.text
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        source.css(method_name.to_s) || super
      end

      def source
        @source
      end
    end
  end
end