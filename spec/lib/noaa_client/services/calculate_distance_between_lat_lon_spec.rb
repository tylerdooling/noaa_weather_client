require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_weather_client/services/calculate_distance_between_lat_lon'

module NoaaWeatherClient
  module Services
    describe CalculateDistanceBetweenLatLon do
      let(:springfield) { [ 37.1962, -93.2861 ] }
      let(:kansas_city) { [ 39.1000, -94.5800 ] }

      it "calculates the distance between two points" do
        expect(CalculateDistanceBetweenLatLon.get_distance(*springfield, *kansas_city))
        .to eq(240.02560432981815)
      end
    end
  end
end
