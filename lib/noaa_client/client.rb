require_relative 'services/forecast_by_day'
require_relative 'services/weather_stations'
require_relative 'services/current_observations'
require_relative 'services/find_nearest_station'
require_relative 'services/zip_code_to_lat_lon'

module NoaaClient
  class Client
    def forecast_by_day(lat, lon, options = {})
      parse_service(options).fetch(lat, lon, options)
    end

    def weather_stations(options = {})
      Services::WeatherStations.new(options).fetch
    end

    def current_observations(lat, lon, options = {})
      station = nearest_weather_station(lat, lon, options)
      Services::CurrentObservations.new(options).fetch(station)
    end

    def nearest_weather_station(lat, lon, options = {})
      stations = options.fetch(:stations, weather_stations)
      Services::FindNearestStation.find(lat, lon, stations)
    end

    def zip_code_to_lat_lon(zip, options = {})
      Services::ZipCodeToLatLon.new(options).convert(zip)
    end

    private

    def parse_service(options)
      options.delete(:service) { |k| Services::ForecastByDay.new }
    end
  end
end
