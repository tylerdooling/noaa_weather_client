
require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_client/responses/current_observation'

module NoaaClient
  module Responses
    describe CurrentObservation do
      let(:body) {
        VCR.use_cassette(:current_observations, match_requests_on: [:method, :uri]) { |c|
          c.http_interactions.response_for(
            VCR::Request.new.tap { |r|
              r.method = :get
              r.uri = 'http://w1.weather.gov/xml/current_obs/KSGF.xml'
            }).body
        }
      }
      let(:current_observation) { CurrentObservation.new body }

      it "requires a response" do
        current_observation
        expect { CurrentObservation.new }.to raise_error(ArgumentError)
      end

      it "exposes location" do
        expect(current_observation.location).to eq('Springfield-Branson National Airport, MO')
      end
      it "exposes station_id" do
        expect(current_observation.station_id).to eq('KSGF')
      end
      it "exposes latitude" do
        expect(current_observation.latitude).to eq(37.23)
      end
      it "exposes longitude" do
        expect(current_observation.longitude).to eq(-93.38)
      end
      it "exposes observation_time_string" do
        expect(current_observation.observation_time_string).to eq('Last Updated on Aug 12 2013, 8:52 pm CDT')
      end
      it "exposes observation_time" do
        expect(current_observation.observation_time).to eq(Time.parse '2013-08-12 20:52:00 -0500')
      end
      it "exposes weather" do
        expect(current_observation.weather).to eq('Fair')
      end
      it "exposes temperature_string" do
        expect(current_observation.temperature_string).to eq('74.0 F (23.3 C)')
      end
      it "exposes temperature_fahrenheit" do
        expect(current_observation.temperature_fahrenheit).to eq(74.0)
      end
      it "exposes temperature_celsius" do
        expect(current_observation.temperature_celsius).to eq(23.3)
      end
      it "exposes relative_humidity" do
        expect(current_observation.relative_humidity).to eq(85)
      end
      it "exposes wind_string" do
        expect(current_observation.wind_string).to eq('Calm')
      end
      it "exposes wind_dir" do
        expect(current_observation.wind_dir).to eq('North')
      end
      it "exposes wind_degrees" do
        expect(current_observation.wind_degrees).to eq(0)
      end
      it "exposes wind_mph" do
        expect(current_observation.wind_mph).to eq(0.0)
      end
      it "exposes wind_kt" do
        expect(current_observation.wind_kt).to eq(0)
      end
      it "exposes pressure_string" do
        expect(current_observation.pressure_string).to eq('1014.7 mb')
      end
      it "exposes pressure_mb" do
        expect(current_observation.pressure_mb).to eq(1014.7)
      end
      it "exposes pressure_in" do
        expect(current_observation.pressure_in).to eq(30.00)
      end
      it "exposes dewpoint_string" do
        expect(current_observation.dewpoint_string).to eq('69.1 F (20.6 C)')
      end
      it "exposes dewpoint_fahrenheit" do
        expect(current_observation.dewpoint_fahrenheit).to eq(69.1)
      end
      it "exposes dewpoint_celsius" do
        expect(current_observation.dewpoint_celsius).to eq(20.6)
      end
      it "exposes visibility_mi" do
        expect(current_observation.visibility_mi).to eq(10.00)
      end
      it "exposes icon_url_base" do
        expect(current_observation.icon_url_base).to eq('http://forecast.weather.gov/images/wtf/small/')
      end
      it "exposes two_day_history_url" do
        expect(current_observation.two_day_history_url).to eq('http://www.weather.gov/data/obhistory/KSGF.html')
      end
      it "exposes icon_url_name" do
        expect(current_observation.icon_url_name).to eq('nskc.png')
      end
      it "exposes ob_url" do
        expect(current_observation.ob_url).to eq('http://www.weather.gov/data/METAR/KSGF.1.txt')
      end
      it "exposes disclaimer_url" do
        expect(current_observation.disclaimer_url).to eq('http://weather.gov/disclaimer.html')
      end
      it "exposes copyright_url" do
        expect(current_observation.copyright_url).to eq('http://weather.gov/disclaimer.html')
      end
      it "exposes privacy_policy_url" do
        expect(current_observation.privacy_policy_url).to eq('http://weather.gov/notice.html')
      end
    end
  end
end
