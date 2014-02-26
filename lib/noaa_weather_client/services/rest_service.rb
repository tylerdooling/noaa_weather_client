require 'net/http'
require_relative '../rest_client_factory'
require_relative '../responses/generic_response'

module NoaaWeatherClient
  module RestService
    def object_from_response(action, url, options = {})
      response_class = options.fetch(:response_class, Responses::GenericResponse)
      client = options.fetch(:client) { RestClientFactory.build_client(url: url) }
      request = build_request_for_action action, url, options
      response_class.new client.request(request).body
    rescue Exception => e
      puts e 
      # return failure response
    end

    # @note Much more to be done here when needed.
    def build_request_for_action(action, url, options = {})
      r_class = case action
                when :get then Net::HTTP::Get
                end
      r_class.new url
    end
  end
end
