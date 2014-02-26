require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_weather_client/responses/lat_lon_list'

module NoaaWeatherClient
  module Responses
    describe LatLonList do
      let(:fake_response) { ZIP_XML }
      let(:lat_lon_list) { LatLonList.new fake_response }

      it "requires a response" do
        lat_lon_list
        expect { LatLonList.new }.to raise_error(ArgumentError)
      end

      it "exposes latitude as float" do
        expect(lat_lon_list.latitude).to eq(37.1962)
      end

      it "exposes longitude as float" do
        expect(lat_lon_list.longitude).to eq(-93.2861)
      end

      ZIP_XML = <<-xml
<?xml version='1.0'?><dwml version='1.0' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:noNamespaceSchemaLocation='http://graphical.weather.gov/xml/DWMLgen/schema/DWML.xsd'><latLonList>37.1962,-93.2861</latLonList></dwml>
      xml
    end
  end
end


