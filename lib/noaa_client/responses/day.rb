module NoaaClient
  module Responses
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

      def high_temp
        @high_temp ||= fetch_parameter('temperature[type=maximum] value')
      end

      def low_temp
        @low_temp ||= fetch_parameter('temperature[type=minimum] value')
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

      attr_reader :period, :index, :parameters
    end
  end
end
