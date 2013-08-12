require_relative '../../spec_helper'
require_relative '../../../lib/noaa_client/soap_client_factory'

module NoaaClient
  describe SoapClientFactory do
    it "builds a soap client with the noaa wdsl" do
      mock_provider = double()
      wsdl = 'http://graphical.weather.gov/xml/DWMLgen/wsdl/ndfdXML.wsdl'
      expect(mock_provider).to receive(:client).with(hash_including(wsdl: wsdl))
      SoapClientFactory.build_client provider: mock_provider
    end
  end
end
