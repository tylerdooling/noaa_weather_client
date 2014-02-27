require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_weather_client/responses/forecast'

module NoaaWeatherClient
  module Responses
    describe Forecast do
      let(:fake_response) { { ndf_dgen_by_day_response: { dwml_by_day_out: load_xml_fixture(:forecast) } } }
      let(:fake_invalid_response) { { ndf_dgen_by_day_response: { dwml_by_day_out: '' } } }
      let(:forecast) { Forecast.new fake_response }

      it "requires a response" do
        forecast
        expect { Forecast.new }.to raise_error(ArgumentError)
      end

      context "when the response is invalid" do
        it "raises an ArgumentError" do
          expect { Forecast.new fake_invalid_response }.to raise_error(ValidatableXmlResponse::InvalidXmlError)
        end
      end

      it "exposes a list of days via enumerable" do
        count = 0
        expect { forecast.each { |d| count += 1 } }.to change { count }.by(7)
      end

      it "exposes number of stations via size" do
        expect(forecast.size).to eq(7)
      end

      describe '#days' do
        let(:period) { double(start_time: Time.parse('2013-08-12 06:00:00 -0500'),
                              end_time: Time.parse('2013-08-13 06:00:00 -0500'),
                              name: 'Today') }
        let(:max) { 86.0 }
        let(:min) { 69.0 }
        let(:weather_summary) { 'Chance Thunderstorms' }
        let(:day) { forecast.days.first }

        it "exposes start_time from period" do
          expect(day.start_time).to eq(period.start_time)
        end

        it "exposes end_time from period" do
          expect(day.end_time).to eq(period.end_time)
        end

        it "exposes name from period" do
          expect(day.name).to eq(period.name)
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
  end
end
