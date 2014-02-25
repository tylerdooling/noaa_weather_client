require_relative '../xml_parser_factory'

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

      class Day
        def initialize(period, index, parameters)
          @period = period
          @index = index
          @parameters = parameters
        end

        def start_time
          @start_time ||= Time.parse(period.start_time.to_s)
        end

        def end_time
          @end_time ||= Time.parse(period.end_time.to_s)
        end

        def maximum_temperature
          @maximum_temperature ||= fetch_parameter('temperature[type=maximum] value')
        end

        def minimum_temperature
          @minimum_temperature ||= fetch_parameter('temperature[type=minimum] value')
        end

        def weather_summary
          @weather ||= fetch_parameter('weather weather-conditions', 'weather-summary')
        end

        private

        def fetch_parameter(css, attribute = nil)
          param = parameters.css(css)[index]
          if param
            attribute ? param[attribute] : param.text
          end
        end

        def fahrenheit_to_celsius(temp)
          (temp.to_f - 32) * 5 / 9
        end

        attr_reader :period, :index, :parameters
      end
    end
  end
end
