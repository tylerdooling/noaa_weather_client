require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_client/services/resolves_zip_code_to_lat_lon'

module NoaaClient
  module Services
    describe ResolvesZipCodeToLatLon do
      it "requires a zip code" do
        ResolvesZipCodeToLatLon.new 65804
        expect { ResolvesZipCodeToLatLon.new }.to raise_error(ArgumentError)
      end

      it "creates a coordinate with the lat and lon in the response" do
        VCR.use_cassette(:zip_to_lat_lon) do
          mock_coordinate_class = double
          expect(mock_coordinate_class).to receive(:new).with(37.1962, -93.2861)
          ResolvesZipCodeToLatLon.new(65804, coordinate_class: mock_coordinate_class).resolve
        end
      end
    end
  end
end
