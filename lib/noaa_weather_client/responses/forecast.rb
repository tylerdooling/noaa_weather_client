require_relative '../xml_parser_factory'
require_relative 'validatable_xml_response'
require 'ostruct'

module NoaaWeatherClient
  module Responses
    class Forecast
      include Enumerable
      include ValidatableXmlResponse

      def initialize(hashed_response)
        @body = XmlParserFactory.build_parser.parse hashed_response[:ndf_dgen_by_day_response][:dwml_by_day_out]
        validate! @body, :dwml
      end

      def each
        days.each { |d| yield d }
      end

      def size
        days.size
      end

      def days
        @days ||= build_days
      end

      private

      attr_reader :body

      def time_layout
        @time_layout ||= body.css("time-layout[summarization='24hourly']").first
      end

      def layout_key
        @layout_key ||= time_layout.css('layout-key').text
      end

      def parameters
        @paramteters ||= body.css('parameters')
      end

      def time_layout_periods
        unless @time_layout_periods
          periods = time_layout.element_children.to_a
          periods.shift #remove layout-key
          @time_layout_periods = [].tap do |arr|
            periods.each_slice(2) do |slice|
              name = slice.first['period-name']
              arr << TimePeriod.new(*slice, name)
            end
          end
        end
        @time_layout_periods
      end

      def build_days
        unless @days
          @day = [].tap do |arr|
            time_layout_periods.each_with_index do |p, i|
              params = build_day_params p, i
              arr << Day.new(params)
            end
          end
        end
      end

      def build_day_params(period, index)
        {
          start_time: Time.parse(period.start_time.to_s),
          end_time: Time.parse(period.end_time.to_s),
          name: period.name,
          maximum_temperature: parameters.css('temperature[type=maximum] value')[index].text.to_f,
          minimum_temperature: parameters.css('temperature[type=minimum] value')[index].text.to_f,
          weather_summary: parameters.css('weather weather-conditions')[index]['weather-summary']
        }
      end

      class Day < OpenStruct; end
      TimePeriod = Struct.new(:start_time, :end_time, :name)
    end
  end
end
