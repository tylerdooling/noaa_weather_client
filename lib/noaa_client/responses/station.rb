require_relative 'reactive_xml_response'

module NoaaClient
  module Responses
    class Station
      include ReactiveXmlResponse

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
    end
  end
end
