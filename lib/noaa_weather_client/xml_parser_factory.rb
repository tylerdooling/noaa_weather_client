require 'nokogiri'

module NoaaWeatherClient
  class XmlParserFactory
    def self.build_parser(options = {})
      options.fetch(:provider, Nokogiri::XML)
    end
  end
end
