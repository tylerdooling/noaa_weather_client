require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_client/responses/day'

module NoaaClient
  module Responses
    describe Day do
      let(:period) { double(start_time: Date.today.to_time, end_time: (Date.today + 1).to_time) }
      let(:index) { 0 }
      let(:parameters) { double(css: []) }
      let(:day) { Day.new period, index, parameters }

      it "requires a period, index, and parameters" do
        Day.new :period, :index, :parameters
        expect { Day.new }.to raise_error(ArgumentError)
        expect { Day.new :period }.to raise_error(ArgumentError)
        expect { Day.new :period, :index }.to raise_error(ArgumentError)
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

        it "fetches high temp from parameters as fahrenheit" do
          expect(day.high_temp_f).to eq(max)
        end

        it "fetches high temp from parameters as celsius" do
          expect(day.high_temp_c).to eq(fahrenheit_to_celsius(max).to_s)
        end

        it "fetches low temp from parameters as fahrenheit" do
          expect(day.low_temp_f).to eq(min)
        end

        it "fetches low temp from parameters as celsuis" do
          expect(day.low_temp_c).to eq(fahrenheit_to_celsius(min).to_s)
        end

        it "fetches weather summary from parameters" do
          expect(day.weather_summary).to eq(weather_summary)
        end
      end
    end
  end
end
