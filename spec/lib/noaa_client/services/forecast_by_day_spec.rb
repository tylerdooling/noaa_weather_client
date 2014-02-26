require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_weather_client/services/forecast_by_day'

module NoaaWeatherClient
  module Services
    describe ForecastByDay do
      it "accepts an options hash" do
        ForecastByDay.new {}
      end

      context "#fetch" do
        let(:options) { { soap_service: double(object_from_response: nil) } }
        let(:forecast) { ForecastByDay.new options }
        let(:lat) { 37.1962 }
        let(:lon) { -93.2861 }

        it "requires lat and lon" do
          forecast.fetch lat, lon
          expect { forecast.fetch }.to raise_error(ArgumentError)
        end

        it "accepts an options hash" do
          forecast.fetch lat, lon, {}
        end

        it "passes optional arguments to the service" do
          args = { key: 'value' }
          expect(options[:soap_service]).to receive(:object_from_response)
            .with(anything, hash_including(key: 'value'), anything)
          forecast.fetch lat, lon, args
        end

        it "passes lat as string to the service" do
          expect(options[:soap_service]).to receive(:object_from_response)
            .with(anything, hash_including(latitude: lat.to_s), anything)
          forecast.fetch lat, lon
        end

        it "passes lon as string to the service" do
          expect(options[:soap_service]).to receive(:object_from_response)
            .with(anything, hash_including(longitude: lon.to_s), anything)
          forecast.fetch lat, lon
        end

        it "passes the soap action to the service" do
          expect(options[:soap_service]).to receive(:object_from_response)
            .with(:ndf_dgen_by_day, anything, anything)
          forecast.fetch lat, lon
        end

        it "passes an optional response class to the service" do
          options[:response_class] = :some_response_class
          expect(options[:soap_service]).to receive(:object_from_response)
            .with(anything, anything, hash_including(response_class: options[:response_class]))

          forecast = ForecastByDay.new options
          forecast.fetch lat, lon
        end
      end
    end
  end
end
