require_relative '../xml_parser_factory'
require_relative 'reactive_response'

module NoaaClient
  module Responses
    class CurrentObservation
      include ReactiveResponse

      def initialize(response)
        @source = XmlParserFactory.build_parser.parse response
      end

      def to_hash(attributes)
        {}.tap { |h| attributes.each { |a| h.store(a, self.send(a)) } }
      end
    end
  end
end
