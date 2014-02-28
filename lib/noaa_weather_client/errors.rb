module NoaaWeatherClient
  module Errors
    class Error < StandardError; end
    class CommunicationError < Error; end
    class InvalidXmlError < ArgumentError; end
  end
end
