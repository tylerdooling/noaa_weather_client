require_relative '../../spec_helper'
require_relative '../../../lib/noaa_client/xml_parser_factory'

module NoaaClient
  describe XmlParserFactory do
    it "accepts an optional options hash" do
      XmlParserFactory.build_parser {}
    end

    it "defaults to Nokogiri::XML" do
      expect(XmlParserFactory.build_parser).to eq(Nokogiri::XML)
    end
  end
end
