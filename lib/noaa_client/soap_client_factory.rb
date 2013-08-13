require 'savon'

module NoaaClient
  module SoapClientFactory
    def self.build_client(options = {})
      provider = options.fetch(:provider, Savon)
      wsdl = options.fetch(:wsdl, 'http://graphical.weather.gov/xml/DWMLgen/wsdl/ndfdXML.wsdl')
      provider.client wsdl: wsdl, log: false
    end
  end
end
