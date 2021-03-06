require_relative 'rest_service'
require_relative '../responses/stations'

module NoaaWeatherClient
  module Services
    class WeatherStations
      include RestService

      URL = 'http://w1.weather.gov/xml/current_obs/index.xml'

      def initialize(options = {})
        @options = options
      end

      def fetch(options = {})
        rest_service.object_from_response(:get, URL, response_class: response_class)
      end

      private

      attr_reader :options

      def rest_service
        options.fetch(:rest_service, self)
      end

      def response_class
        options.fetch(:response_class, Responses::Stations)
      end
    end
  end
end
