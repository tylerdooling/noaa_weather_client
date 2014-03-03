require 'noaa_weather_client/cli/templates'

module NoaaWeatherClient
  class CLI
    def self.postal_code_to_coordinate(postal_code, buffer = STDOUT)
      client = NoaaWeatherClient.build_client
      coordinate = client.postal_code_to_coordinate postal_code
      buffer.puts Templates::PostalCode.new(coordinate).to_s
    end

    attr_writer :buffer

    def initialize(latitude, longitude)
      @coordinate = Coordinate.new(latitude, longitude)
      raise ArgumentError, "Invalid coordinate #{latitude}, #{longitude}" unless coordinate.valid?
    end

    def render(*features)
      features.each { |f| render_feature buffer, f }
    end

    private

    attr_reader :coordinate

    def render_feature(buffer, feature)
      if feature.to_s == 'observations'
        observations = client.current_observations(coordinate.latitude, coordinate.longitude)
        buffer.puts Templates::CurrentObservations.new(observations).to_s
      elsif feature.to_s == 'forecast'
        forecast = client.forecast_by_day(coordinate.latitude, coordinate.longitude)
        buffer.puts Templates::Forecast.new(forecast).to_s
      end
    end

    def buffer
      @buffer || STDOUT
    end

    def client
      @client ||= NoaaWeatherClient.build_client
    end

    Coordinate = Struct.new(:latitude, :longitude) do
      def valid?
        latitude && longitude rescue false
      end

      def latitude; Float(self[:latitude]) end
      def longitude; Float(self[:longitude]) end
    end
  end
end
