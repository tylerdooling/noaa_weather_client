require_relative '../xml_parser_factory'
require_relative 'reactive_xml_response'
require_relative 'validatable_xml_response'

module NoaaWeatherClient
  module Responses
    class LatLonList
      include ReactiveXmlResponse
      include ValidatableXmlResponse

      def initialize(response)
        @source = XmlParserFactory.build_parser.parse(response)
        validate! @source, :dwml
      end

      def latitude
        @latitude ||= latLonList.split(",").first.to_f
      end

      def longitude
        @longitude ||= latLonList.split(",").last.to_f
      end
    end
  end
end
