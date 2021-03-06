require_relative '../../spec_helper'
require_relative '../../../lib/noaa_weather_client/client'

module NoaaWeatherClient
  describe Client do
    let(:client) { Client.new }

    it "requires no arguments" do
      Client.new
    end

    context "#forecast_by_day" do
      it "fetches a 7 day forecast by default" do
        VCR.use_cassette(:forecast_by_day_7) do
          expect(client.forecast_by_day(37.1962, -93.2861).size).to eq(7)
        end
      end

      it "fetches less than 7 day forecast if requested" do
        VCR.use_cassette(:forecast_by_day_3) do
          expect(client.forecast_by_day(37.1962, -93.2861, days: 3).size).to eq(3)
        end
      end
    end

    context "#weather_stations" do
      it "fetches a list of all weather stations" do
        VCR.use_cassette(:weather_stations) do
          expect(client.weather_stations.size).to be > 2500
        end
      end

      it "caches weather stations" do
        VCR.use_cassette(:weather_stations) do
          stations = client.weather_stations
          expect(client.weather_stations.object_id).to eq(stations.object_id)
        end
      end

      it "reloads stations with :reload flag" do
        VCR.use_cassette(:weather_stations) do
          stations = client.weather_stations
          client.instance_variable_set('@weather_stations', double)
          expect(client.weather_stations(relaod: true).object_id).to_not eq(stations.object_id)
        end
      end
    end

    context "#current_observations" do
      it "fetches the current weather observation from the station nearest the coordinates" do
        VCR.use_cassette(:current_observations) do
          expect(client.current_observations(37.1962, -93.2861).station_id).to eq('KSGF')
        end
      end

      it "fetches the current weather observation with temp in f" do
        VCR.use_cassette(:current_observations) do
          expect(client.current_observations(37.1962, -93.2861).temp_f).to be
        end
      end

      it "fetches the current weather observation with weather condition" do
        VCR.use_cassette(:current_observations) do
          expect(client.current_observations(37.1962, -93.2861).weather).to be
        end
      end
    end

    context "#nearest_weather_station" do
      it "fetches the station nearest the coordinates" do
        VCR.use_cassette(:nearest_weather_station) do
          expect(client.nearest_weather_station(37.1962, -93.2861).station_id).to eq('KSGF')
        end
      end

      it "uses a cached set of stations if provided" do
        stations = [ double(latitude: 38.3456, longitude: -97.3345, station_id: 'cached_station') ]
        expect(
          client.nearest_weather_station(37.1962, -93.2861, stations: stations).station_id
        ).to eq('cached_station')
      end
    end

    context "#postal_code_to_coordinate" do
      it "resolves a postal code to coordinate" do
        VCR.use_cassette(:postal_code_to_coordinate) do
          expect(client.postal_code_to_coordinate(65804).latitude).to eq(37.1962)
          expect(client.postal_code_to_coordinate(65804).longitude).to eq(-93.2861)
        end
      end
    end
  end
end
