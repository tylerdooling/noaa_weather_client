require "noaa_client/version"
require_relative 'noaa_client/client'

module NoaaClient
  def self.build_client
    Client.new
  end
end
