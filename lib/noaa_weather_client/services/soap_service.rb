require 'savon'
require_relative '../soap_client_factory'
require_relative '../responses/generic_response'
require_relative '../errors'

module NoaaWeatherClient
  module SoapService
    def object_from_response(soap_action, message, options = {})
      client = options.fetch(:client, SoapClientFactory.build_client)
      response_class = options.fetch(:response_class, Responses::GenericResponse)
      response_class.new client.call(soap_action, message: message).body
    rescue Savon::Error => e
      raise Errors::CommunicationError, e.message, e.backtrace
    end
  end
end
