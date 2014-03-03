require "noaa_weather_client/version"
require_relative 'noaa_weather_client/client'
require_relative 'noaa_weather_client/cli'

module NoaaWeatherClient
  def self.build_client
    Client.new
  end
end
