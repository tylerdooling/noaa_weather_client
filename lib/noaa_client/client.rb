require_relative 'services/forecast_by_day'
require_relative 'services/weather_stations'

module NoaaClient
  class Client
    def forecast_by_day(lat, lon, options = {})
      parse_service(options).fetch(lat, lon, options)
    end

    def weather_stations(options = {})
      Services::WeatherStations.new(options).fetch(options)
    end

    private

    def parse_service(options)
      options.delete(:service) { |k| Services::ForecastByDay.new }
    end
  end
end
