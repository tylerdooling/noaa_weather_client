module NoaaWeatherClient
  module Responses
    class GenericResponse
      def initialize(response_body)
        @response_body = response_body
      end
    end
  end
end
