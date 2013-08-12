require 'nokogiri'

module NoaaClient
  class XmlParserFactory
    def self.build_parser(options = {})
      options.fetch(:provider, Nokogiri::XML)
    end
  end
end
