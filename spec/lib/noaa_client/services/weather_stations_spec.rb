require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_weather_client/services/weather_stations'

module NoaaWeatherClient
  module Services
    describe WeatherStations do
      it "accepts an options hash" do
        WeatherStations.new {}
      end

      context "#fetch" do
        let(:options) { { rest_service: double(object_from_response: nil) } }
        let(:weather_stations) { WeatherStations.new options }

        it "accepts an options hash" do
          weather_stations.fetch {}
        end

        it "passes the get action to the service" do
          expect(options[:rest_service]).to receive(:object_from_response)
            .with(:get, anything, anything)
          weather_stations.fetch
        end

        it "passes the noaa stations url to the service" do
          expect(options[:rest_service]).to receive(:object_from_response)
            .with(anything, 'http://w1.weather.gov/xml/current_obs/index.xml', anything)
          weather_stations.fetch
        end

        it "passes an optional response class to the service" do
          options[:response_class] = :some_response_class
          expect(options[:rest_service]).to receive(:object_from_response)
            .with(anything, anything, hash_including(response_class: options[:response_class]))
          weather_stations.fetch
        end
      end
    end
  end
end
