require 'savon'

module NoaaWeatherClient
  module SoapClientFactory
    WSDL = 'http://graphical.weather.gov/xml/DWMLgen/wsdl/ndfdXML.wsdl'

    def self.build_client(options = {})
      provider = options.fetch(:provider, Savon)
      wsdl = options.fetch(:wsdl, WSDL)
      provider.client(wsdl: wsdl,
                      log: false,
                      open_timeout: 10,
                      read_timeout: 30,
                      ssl_verify_mode: :none)
    end
  end
end
