require_relative '../xml_parser_factory'
require_relative 'reactive_response'

module NoaaClient
  module Responses
    class CurrentObservation
      include ReactiveResponse

      def initialize(response)
        @source = XmlParserFactory.build_parser.parse response
      end
    end
  end
end
