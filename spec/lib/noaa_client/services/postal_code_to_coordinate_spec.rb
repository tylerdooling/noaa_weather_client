require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_weather_client/services/postal_code_to_coordinate'

module NoaaWeatherClient
  module Services
    describe PostalCodeToCoordinate do
      it "accepts an options hash" do
        PostalCodeToCoordinate.new {}
      end

      context "#resolve" do
        let(:options) { { rest_service: double(object_from_response: nil) } }
        let(:zip) { 90210 }
        let(:zip_lat_lon) { PostalCodeToCoordinate.new options }

        it "accepts an options hash" do
          zip_lat_lon.resolve options
        end

        it "passes action to the service" do
          expect(options[:rest_service]).to receive(:object_from_response)
          .with(:get, anything, anything)
          zip_lat_lon.resolve zip
        end

        it "passes zip as string to the service" do
          expect(options[:rest_service]).to receive(:object_from_response)
            .with(anything, /#{zip}/, anything)
          zip_lat_lon.resolve zip
        end

        it "passes an optional response class to the service" do
          options[:response_class] = :some_response_class
          expect(options[:rest_service]).to receive(:object_from_response)
            .with(anything, anything, hash_including(response_class: options[:response_class]))
          zip_lat_lon.resolve zip
        end
      end
    end
  end
end
