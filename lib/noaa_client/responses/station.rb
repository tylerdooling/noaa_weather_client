require_relative 'reactive_response'

module NoaaClient
  module Responses
    class Station
      include ReactiveResponse

      def initialize(station)
        @source = station
      end

      def latitude
        source.css('latitude').text.to_f
      end

      def longitude
        source.css('longitude').text.to_f
      end

      def xml_url
        @xml_url ||= begin
                       path = URI(source.css('xml_url').text).path
                       "http://w1.weather.gov#{path}"
                     end
      end

      private

      attr_reader :source

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
    end
  end
end
