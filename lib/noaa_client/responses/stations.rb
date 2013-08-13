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

      def fetch(index)
        stations.fetch index
      end

      alias_method :'[]', :fetch

      def size
        stations.size
      end

      private

      attr_reader :body, :options

      def stations
        @stations ||= body.css('station').map do |station|
          station_class.new station
        end
      end

      def station_class
        options.fetch(:station_class, Station)
      end
    end
  end
end
