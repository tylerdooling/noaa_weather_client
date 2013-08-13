require_relative '../xml_parser_factory'
require_relative 'day'

module NoaaClient
  module Responses
    class Forecast
      include Enumerable
      TimePeriod = Struct.new(:start_time, :end_time)

      def initialize(hashed_response)
        @body = XmlParserFactory.build_parser.parse hashed_response[:ndf_dgen_by_day_response][:dwml_by_day_out]
      end

      def each
        days.each { |d| yield d }
      end

      def today
        days.first if days.first.start_time.to_date == Date.today
      end

      def tomorrow
        today ? days[1] : days.first
      end

      def size
        days.size
      end

      private

      attr_reader :body

      def days
        @days ||= build_days
      end

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
              arr << TimePeriod.new(*slice)
            end
          end
        end
        @time_layout_periods
      end

      def build_days
        unless @days
          @day = [].tap do |arr|
            time_layout_periods.each_with_index do |p, i|
              arr << Day.new(p, i, parameters)
            end
          end
        end
      end
    end
  end
end
