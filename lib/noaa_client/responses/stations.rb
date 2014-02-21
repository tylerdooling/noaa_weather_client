require_relative '../xml_parser_factory'
require_relative 'station'
require 'forwardable'

module NoaaClient
  module Responses
    class Stations
      include Enumerable
      extend Forwardable

      def_delegators :stations, :'[]', :fetch, :sort_by!, :take, :size

      def initialize(response, options = {})
        @body = XmlParserFactory.build_parser.parse response
        @options = options
      end

      def each
        stations.each { |s| yield s }
      end

      def to_xml
        body.to_xml
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
