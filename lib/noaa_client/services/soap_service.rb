require 'savon'
require_relative '../soap_client_factory'
require_relative '../responses/generic_response'

module NoaaClient
  module SoapService
    def object_from_response(soap_action, message, options = {})
      client = options.fetch(:client, SoapClientFactory.build_client)
      response_class = options.fetch(:response_class, Responses::GenericResponse)
      response_class.new client.call(soap_action, message: message).body
    rescue Savon::Error
      # return failure response
    end
  end
end
