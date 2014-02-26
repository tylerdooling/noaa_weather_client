require_relative 'services/forecast_by_day'
require_relative 'services/weather_stations'
require_relative 'services/current_observations'
require_relative 'services/find_nearest_station'
require_relative 'services/zip_code_to_lat_lon'

module NoaaWeatherClient
  # Provides entry point for interacting with the noaa api via multiple services.
  class Client
    # Fetches a daily forecast for a location from today. Default is 7 days.
    # The forecast for the current day ceases to be returned after 6:00pm at the
    # observation area.
    # @param lat [Float] latitude
    # @param lon [Float] longitude
    # @return [Responses::Forecast] a list of daily forecasts.
    def forecast_by_day(lat, lon, options = {})
      Services::ForecastByDay.new.fetch(lat, lon, options)
    end

    # Retrieves a list of weather stations from noaa.
    # @return [Responses::Stations] a list of weather stations.
    def weather_stations(options = {})
      if options.delete(:reload) { false } || @weather_stations.nil?
        @weather_stations = Services::WeatherStations.new(options).fetch
      end
      @weather_stations
    end

    # Retrieves the current weather observations for a location.
    # @note It is important to cache a copy of the available stations for use here, as the xml stations response is quite large noaa does not appreciate repeated calls.
    # @param lat [Float] latitude
    # @param lon [Float] longitude
    # @param [Hash] options
    # @option options [Responses::Stations] stations A cached stations response to prevent having to query noaa for the list.
    # @return [Responses::CurrentObservation]
    def current_observations(lat, lon, options = {})
      station = options.fetch(:station) { nearest_weather_station(lat, lon, options) }
      Services::CurrentObservations.new(options).fetch(station)
    end

    # Retrieves the weather station nearest to the location.
    # @note It is important to cache a copy of the available stations for use here, as the xml stations response is quite large noaa does not appreciate repeated calls.
    # @param lat [Float] latitude
    # @param lon [Float] longitude
    # @param [Hash] options
    # @option options [Responses::Stations] stations A cached stations response to prevent having to query noaa for the list.
    # @return [Responses::Station]
    def nearest_weather_station(lat, lon, options = {})
      stations = options.fetch(:stations) { weather_stations }
      Services::FindNearestStation.find(lat, lon, stations)
    end

    # Converts a zip code to a latitude and longitude.
    # @param lat [Float] latitude
    # @param lon [Float] longitude
    # @return [Responses::LatLonList]
    def zip_code_to_lat_lon(zip, options = {})
      Services::ZipCodeToLatLon.new(options).resolve(zip)
    end
  end
end
