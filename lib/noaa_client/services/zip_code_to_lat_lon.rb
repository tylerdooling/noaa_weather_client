require_relative 'soap_service'
require_relative '../responses/lat_lon_list'

module NoaaClient
  module Services
    class ZipCodeToLatLon
      include SoapService

      def initialize(options = {})
        @options = options
      end

      def convert(zip, options = {})
        opts = { 'zipCodeList' => zip.to_s }
        soap_service.object_from_response(:lat_lon_list_zip_code,
                                          opts,
                                          response_class: response_class)
      end

      private

      attr_reader :options

      def soap_service
        options.fetch(:soap_service, self)
      end

      def response_class
        options.fetch(:response_class, Responses::LatLonList)
      end
    end
  end
end
