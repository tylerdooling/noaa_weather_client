require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_client/services/current_observations'

module NoaaClient
  module Services
    describe CurrentObservations do
      let(:mock_station) { double(xml_url: 'http://w1.weather.gov/xml/current_obs/KSGF.xml') }
      let(:current_observations) { CurrentObservations.new options }

      it "accepts an options hash" do
        CurrentObservations.new {}
      end

      context "#fetch" do
        let(:options) { { rest_service: double(object_from_response: nil) } }

        it "requires a station" do
          current_observations.fetch mock_station, options
          expect { current_observations.fetch }.to raise_error(ArgumentError)
        end

        it "accepts an options hash" do
          current_observations.fetch mock_station, options
        end

        it "passes the stations xml url to the service" do
          expect(options[:rest_service]).to receive(:object_from_response)
            .with(anything, mock_station.xml_url, anything)
          current_observations.fetch mock_station
        end

        it "passes the get action to the service" do
          expect(options[:rest_service]).to receive(:object_from_response)
            .with(:get, anything, anything)
          current_observations.fetch mock_station
        end

        it "passes an optional response class to the service" do
          options[:response_class] = :some_response_class
          expect(options[:rest_service]).to receive(:object_from_response)
            .with(anything, anything, hash_including(response_class: options[:response_class]))
          current_observations.fetch mock_station
        end
      end
    end
  end
end
