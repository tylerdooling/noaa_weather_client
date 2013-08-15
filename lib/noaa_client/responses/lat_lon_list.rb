require_relative '../xml_parser_factory'
require_relative 'reactive_response'

module NoaaClient
  module Responses
    class LatLonList
      include ReactiveResponse

      def initialize(response)
        @source = XmlParserFactory.build_parser.parse(response)
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
