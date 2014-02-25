require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_client/responses/forecast'

module NoaaClient
  module Responses
    describe Forecast do
      let(:fake_response) { { ndf_dgen_by_day_response: { dwml_by_day_out: FORECAST_XML } } }
      let(:forecast) { Forecast.new fake_response }

      it "requires a response" do
        forecast
        expect { Forecast.new }.to raise_error(ArgumentError)
      end

      it "exposes a list of days via enumerable" do
        count = 0
        expect { forecast.each { |d| count += 1 } }.to change { count }.by(7)
      end

      it "exposes number of stations via size" do
        expect(forecast.size).to eq(7)
      end

      describe Forecast::Day do
        let(:period) { double(start_time: Date.today.to_time, end_time: (Date.today + 1).to_time) }
        let(:index) { 0 }
        let(:parameters) { double(css: []) }
        let(:day) { Forecast::Day.new period, index, parameters }

        it "requires a period, index, and parameters" do
          Forecast::Day.new :period, :index, :parameters
          expect { Forecast::Day.new }.to raise_error(ArgumentError)
          expect { Forecast::Day.new :period }.to raise_error(ArgumentError)
          expect { Forecast::Day.new :period, :index }.to raise_error(ArgumentError)
        end

        it "exposes start_time from period" do
          expect(day.start_time).to eq(period.start_time)
        end

        it "exposes end_time from period" do
          expect(day.end_time).to eq(period.end_time)
        end

        context "data from parameters" do
          let(:max) { 85 }
          let(:min) { 65 }
          let(:weather_summary) { 'Cloudy' }

          def fahrenheit_to_celsius(temp)
            (temp.to_f - 32) * 5 / 9
          end

          before :each do
            allow(parameters).to receive(:css)
            .with('temperature[type=maximum] value')
            .and_return([double(text: max)])
            allow(parameters).to receive(:css)
            .with('temperature[type=minimum] value')
            .and_return([double(text: min)])
            allow(parameters).to receive(:css)
            .with('weather weather-conditions')
            .and_return([double('[]' => weather_summary)])
          end

          it "fetches max temp" do
            expect(day.maximum_temperature).to eq(max)
          end

          it "fetches min temp" do
            expect(day.minimum_temperature).to eq(min)
          end

          it "fetches weather summary from parameters" do
            expect(day.weather_summary).to eq(weather_summary)
          end
        end
      end


      FORECAST_XML =<<-RESPONSE
<?xml version="1.0"?>
<dwml version="1.0" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://graphical.weather.gov/xml/DWMLgen/schema/DWML.xsd">
  <head>
    <product srsName="WGS 1984" concise-name="dwmlByDay" operational-mode="official">
      <title>NOAA's National Weather Service Forecast by 24 Hour Period</title>
      <field>meteorological</field>
      <category>forecast</category>
      <creation-date refresh-frequency="PT1H">2013-08-12T03:47:26Z</creation-date>
    </product>
    <source>
      <more-information>http://graphical.weather.gov/xml/</more-information>
      <production-center>Meteorological Development Laboratory<sub-center>Product Generation Branch</sub-center></production-center>
      <disclaimer>http://www.nws.noaa.gov/disclaimer.html</disclaimer>
      <credit>http://www.weather.gov/</credit>
      <credit-logo>http://www.weather.gov/images/xml_logo.gif</credit-logo>
      <feedback>http://www.weather.gov/feedback.php</feedback>
    </source>
  </head>
  <data>
    <location>
      <location-key>point1</location-key>
      <point latitude="37.20" longitude="-93.29"/>
    </location>
    <moreWeatherInformation applicable-location="point1">http://forecast.weather.gov/MapClick.php?textField1=37.20&amp;textField2=-93.29</moreWeatherInformation>
    <time-layout time-coordinate="local" summarization="24hourly">
      <layout-key>k-p24h-n7-1</layout-key>
      <start-valid-time>2013-08-12T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-13T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-13T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-14T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-14T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-15T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-15T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-16T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-16T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-17T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-17T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-18T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-18T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-19T06:00:00-05:00</end-valid-time>
    </time-layout>
    <time-layout time-coordinate="local" summarization="12hourly">
      <layout-key>k-p12h-n14-2</layout-key>
      <start-valid-time>2013-08-12T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-12T18:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-12T18:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-13T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-13T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-13T18:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-13T18:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-14T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-14T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-14T18:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-14T18:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-15T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-15T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-15T18:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-15T18:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-16T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-16T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-16T18:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-16T18:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-17T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-17T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-17T18:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-17T18:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-18T06:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-18T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-18T18:00:00-05:00</end-valid-time>
      <start-valid-time>2013-08-18T18:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-19T06:00:00-05:00</end-valid-time>
    </time-layout>
    <time-layout time-coordinate="local" summarization="24hourly">
      <layout-key>k-p7d-n1-3</layout-key>
      <start-valid-time>2013-08-12T06:00:00-05:00</start-valid-time>
      <end-valid-time>2013-08-19T06:00:00-05:00</end-valid-time>
    </time-layout>
    <parameters applicable-location="point1">
      <temperature type="maximum" units="Fahrenheit" time-layout="k-p24h-n7-1">
        <name>Daily Maximum Temperature</name>
        <value>86</value>
        <value>81</value>
        <value>78</value>
        <value>77</value>
        <value>78</value>
        <value>81</value>
        <value>83</value>
      </temperature>
      <temperature type="minimum" units="Fahrenheit" time-layout="k-p24h-n7-1">
        <name>Daily Minimum Temperature</name>
        <value>69</value>
        <value>65</value>
        <value>57</value>
        <value>57</value>
        <value>59</value>
        <value>61</value>
        <value xsi:nil="true"/>
      </temperature>
      <probability-of-precipitation type="12 hour" units="percent" time-layout="k-p12h-n14-2">
        <name>12 Hourly Probability of Precipitation</name>
        <value>46</value>
        <value>46</value>
        <value>54</value>
        <value>32</value>
        <value>12</value>
        <value>4</value>
        <value>6</value>
        <value>6</value>
        <value>7</value>
        <value>5</value>
        <value>4</value>
        <value>5</value>
        <value>5</value>
        <value xsi:nil="true"/>
      </probability-of-precipitation>
      <hazards time-layout="k-p7d-n1-3">
        <name>Watches, Warnings, and Advisories</name>
        <hazard-conditions xsi:nil="true"/>
      </hazards>
      <weather time-layout="k-p24h-n7-1">
        <name>Weather Type, Coverage, and Intensity</name>
        <weather-conditions weather-summary="Chance Thunderstorms">
          <value coverage="chance" intensity="none" weather-type="thunderstorms" qualifier="none"/>
          <value coverage="chance" intensity="light" additive="and" weather-type="rain showers" qualifier="none"/>
        </weather-conditions>
        <weather-conditions weather-summary="Chance Thunderstorms">
          <value coverage="chance" intensity="none" weather-type="thunderstorms" qualifier="none"/>
          <value coverage="chance" intensity="light" additive="and" weather-type="rain showers" qualifier="none"/>
        </weather-conditions>
        <weather-conditions weather-summary="Partly Sunny"/>
        <weather-conditions weather-summary="Partly Sunny"/>
        <weather-conditions weather-summary="Mostly Sunny"/>
        <weather-conditions weather-summary="Mostly Sunny"/>
        <weather-conditions weather-summary="Mostly Sunny"/>
      </weather>
      <conditions-icon type="forecast-NWS" time-layout="k-p24h-n7-1">
        <name>Conditions Icons</name>
        <icon-link>http://www.nws.noaa.gov/weather/images/fcicons/tsra50.jpg</icon-link>
        <icon-link>http://www.nws.noaa.gov/weather/images/fcicons/tsra50.jpg</icon-link>
        <icon-link>http://www.nws.noaa.gov/weather/images/fcicons/sct.jpg</icon-link>
        <icon-link>http://www.nws.noaa.gov/weather/images/fcicons/sct.jpg</icon-link>
        <icon-link>http://www.nws.noaa.gov/weather/images/fcicons/few.jpg</icon-link>
        <icon-link>http://www.nws.noaa.gov/weather/images/fcicons/few.jpg</icon-link>
        <icon-link>http://www.nws.noaa.gov/weather/images/fcicons/few.jpg</icon-link>
      </conditions-icon>
    </parameters>
  </data>
</dwml>
      RESPONSE
    end
  end
end
