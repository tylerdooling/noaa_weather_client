require 'net/http'
require 'uri'

module NoaaClient
  module RestClientFactory
    def self.build_client(options = {})
      provider = options.fetch(:provider, Net::HTTP)
      uri = URI(options.fetch(:url))
      provider.new uri.host, uri.port
    end
  end
end
