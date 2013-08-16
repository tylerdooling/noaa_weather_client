require 'savon'

module NoaaClient
  module SoapClientFactory
    def self.build_client(options = {})
      provider = options.fetch(:provider, Savon)
      wsdl = options.fetch(:wsdl, 'http://graphical.weather.gov/xml/DWMLgen/wsdl/ndfdXML.wsdl')
      provider.client(wsdl: wsdl,
                      log: false,
                      open_timeout: 10,
                      read_timeout: 30,
                      ssl_verify_mode: :none)
    end
  end
end
