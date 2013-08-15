require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_client/services/zip_code_to_lat_lon'

module NoaaClient
  module Services
    describe ZipCodeToLatLon do
      it "accepts an options hash" do
        ZipCodeToLatLon.new {}
      end

      context "#convert" do
        let(:options) { { rest_service: double(object_from_response: nil) } }
        let(:zip) { 90210 }
        let(:zip_lat_lon) { ZipCodeToLatLon.new options }

        it "accepts an options hash" do
          zip_lat_lon.convert options
        end

        it "passes action to the service" do
          expect(options[:rest_service]).to receive(:object_from_response)
          .with(:get, anything, anything)
          zip_lat_lon.convert zip
        end

        it "passes zip as string to the service" do
          expect(options[:rest_service]).to receive(:object_from_response)
            .with(anything, /#{zip}/, anything)
          zip_lat_lon.convert zip
        end

        it "passes an optional response class to the service" do
          options[:response_class] = :some_response_class
          expect(options[:rest_service]).to receive(:object_from_response)
            .with(anything, anything, hash_including(response_class: options[:response_class]))
          zip_lat_lon.convert zip
        end
      end
    end
  end
end
