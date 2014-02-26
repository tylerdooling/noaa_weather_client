require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_weather_client/services/find_nearest_station'

module NoaaWeatherClient
  module Services
    describe FindNearestStation do
      let(:location) { double(latitude:39.1000, longitude: -94.5800) } #kansas city
      let(:washington_dc) { double(station_name: 'Washington D.C.', latitude: 38.8951 , longitude: -77.0367) }
      let(:detroit) { double(station_name: 'Detroit', latitude: 42.3314 , longitude: -83.0458) }
      let(:stations) { [ washington_dc, detroit ] }

      it "requires latitude, longitude, and a list of stations" do
        FindNearestStation.find(location.latitude, location.longitude, stations)
        expect { FindNearestStation.find }.to raise_error(ArgumentError)
        expect { FindNearestStation.find location.latitude}.to raise_error(ArgumentError)
        expect { FindNearestStation.find location.latitude, location.longitude}.to raise_error(ArgumentError)
      end

      it "accepts an options hash" do
        FindNearestStation.find(location.latitude, location.longitude, stations, {})
      end

      it "accepts a callable filter for the stations" do
        mock_filter = ->(station) { station == washington_dc ? true : false }
        FindNearestStation.find(location.latitude, location.longitude, stations, { filter: mock_filter })
      end

      it "returns the closest of the provided stations" do
        expect(
          FindNearestStation.find(location.latitude, location.longitude, stations)
          .station_name
        ).to eq(detroit.station_name)
      end
    end
  end
end
