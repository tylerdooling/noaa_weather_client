require_relative 'rest_service'
require_relative '../responses/current_observation'

module NoaaClient
  module Services
    class CurrentObservations
      include RestService

      def initialize(options = {})
        @options = options
      end

      def fetch(station, options = {})
        rest_service.object_from_response(:get,
                                          station.xml_url,
                                          response_class: response_class)
      end

      private

      attr_reader :options

      def rest_service
        options.fetch(:rest_service, self)
      end

      def response_class
        options.fetch(:response_class, Responses::CurrentObservation)
      end
    end
  end
end
