require_relative '../xml_parser_factory'
require_relative 'station'

module NoaaClient
  module Responses
    class Stations
      include Enumerable

      def initialize(response, options = {})
        @body = XmlParserFactory.build_parser.parse response
        @options = options
      end

      def each
        stations.each { |s| yield s }
      end

      private

      attr_reader :body, :options

      def stations
        @stations ||= body.css('station').map do |station|
          station_class.new map_station_attributes(station)
        end
      end

      def station_class
        options.fetch(:station_class, Station)
      end

      def map_station_attributes(station)
        {}.tap do |h|
          station.element_children.each do |c|
            h.store c.name, c.text
          end
        end
      end
    end
  end
end
