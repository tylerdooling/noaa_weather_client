require 'uri'
require_relative '../../spec_helper'
require_relative '../../../lib/noaa_weather_client/rest_client_factory'

module NoaaWeatherClient
  describe RestClientFactory do
    it "builds a rest client with the provided url" do
      mock_provider = double()
      url = "http://www.google.com"
      uri = URI(url)
      expect(mock_provider).to receive(:new).with(uri.host, uri.port)
      RestClientFactory.build_client provider: mock_provider, url: url
    end
  end
end
