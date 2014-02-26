require 'net/http'
require 'uri'

module NoaaWeatherClient
  module RestClientFactory
    def self.build_client(options = {})
      provider = options.fetch(:provider, Net::HTTP)
      uri = URI(options.fetch(:url))
      provider.new uri.host, uri.port
    end
  end
end
