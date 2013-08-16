require 'nokogiri'
require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_client/responses/stations'

module NoaaClient
  module Responses
    describe Stations do
      let(:fake_response) { STATIONS_XML }
      let(:stations) { Stations.new fake_response }

      it "requires a response" do
        stations
        expect { Stations.new }.to raise_error(ArgumentError)
      end

      it "exposes a list of stations via enumerable" do
        count = 0
        expect { stations.each { |d| count += 1 } }.to change { count }.by(2)
      end

      it "passes station xml to the station class" do
        mock_station_class = double(new: nil)
        first, last = Nokogiri::XML.parse(fake_response).css('station')
        expect(mock_station_class).to receive(:new).with { |station|
          station.to_xml == first.to_xml
        }
        expect(mock_station_class).to receive(:new).with { |station|
          station.to_xml == last.to_xml
        }
        Stations.new(fake_response, station_class: mock_station_class).each { |s| }
      end

      it "allows fetching of stations via array#fetch" do
        expect(stations.fetch(0).station_id).to eq('TAPA')
      end

      it "allows fetching of stations via array#[]" do
        expect(stations[0].station_id).to eq('TAPA')
      end

      it "exposes number of stations via size" do
        expect(stations.size).to eq(2)
      end

      it "exposes source xml" do
        expect(stations.to_xml).to eq(fake_response)
      end

      STATIONS_XML =<<-RESPONSE
<?xml version="1.0" encoding="UTF-8"?>
<wx_station_index>
  <credit>NOAA's National Weather Service</credit>
  <credit_URL>http://weather.gov/</credit_URL>
  <image>
    <url>http://weather.gov/images/xml_logo.gif</url>
    <title>NOAA's National Weather Service</title>
    <link>http://weather.gov</link>
  </image>
  <suggested_pickup>08:00 EST</suggested_pickup>
  <suggested_pickup_period>1140</suggested_pickup_period>
  <station>
    <station_id>TAPA</station_id>
    <state>AG</state>
    <station_name>Vc Bird Intl Airport Antigua</station_name>
    <latitude>17.117</latitude>
    <longitude>-61.783</longitude>
    <html_url>http://weather.noaa.gov/weather/current/TAPA.html</html_url>
    <rss_url>http://weather.gov/xml/current_obs/TAPA.rss</rss_url>
    <xml_url>http://weather.gov/xml/current_obs/TAPA.xml</xml_url>
  </station>

  <station>
    <station_id>TKPN</station_id>
    <state>AG</state>
    <station_name>Charlestown/Newcast</station_name>
    <latitude>17.2</latitude>
    <longitude>-62.583</longitude>
    <html_url>http://weather.noaa.gov/weather/current/TKPN.html</html_url>
    <rss_url>http://weather.gov/xml/current_obs/TKPN.rss</rss_url>
    <xml_url>http://weather.gov/xml/current_obs/TKPN.xml</xml_url>
  </station>
</wx_station_index>
      RESPONSE
    end
  end
end
