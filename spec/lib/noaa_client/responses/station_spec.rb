require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_client/responses/station'

module NoaaClient
  module Responses
    describe Station do
      let(:attributes) { {
        "station_id" => 'TAPA',
        "state" => 'AG',
        "station_name" => 'Vc Bird Intl Airport Antigua',
        "latitude" => '17.117',
        "longitude" => '-61.783',
        "html_url" => 'http://weather.noaa.gov/weather/current/TAPA.html',
        "rss_url" => 'http://weather.gov/xml/current_obs/TAPA.rss',
        "xml_url" => 'http://weather.gov/xml/current_obs/TAPA.xml'
      }}
      let(:station) { Station.new attributes }

      it "accepts an attributes hash" do
        station
      end

      it "exposes station id" do
        expect(station.station_id).to eq('TAPA')
      end

      it "exposes station name" do
        expect(station.station_name).to eq('Vc Bird Intl Airport Antigua')
      end

      it "exposes state" do
        expect(station.state).to eq('AG')
      end

      it "exposes latitude" do
        expect(station.latitude).to eq(17.117)
      end

      it "exposes longitude" do
        expect(station.longitude).to eq(-61.783)
      end

      it "exposes xml url" do
        expect(station.xml_url).to eq('http://weather.gov/xml/current_obs/TAPA.xml')
      end
    end
  end
end
