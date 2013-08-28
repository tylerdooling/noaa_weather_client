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

      def high_temp_f
        @high_temp_f ||= fetch_parameter('temperature[type=maximum] value')
      end

      def high_temp_c
        @high_temp_c ||= fahrenheit_to_celsius(high_temp_f).to_s
      end

      def low_temp_f
        @low_temp_f ||= fetch_parameter('temperature[type=minimum] value')
      end

      def low_temp_c
        @low_temp_c ||= fahrenheit_to_celsius(low_temp_f).to_s
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
