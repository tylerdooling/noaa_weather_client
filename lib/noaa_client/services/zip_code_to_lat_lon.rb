require_relative 'rest_service'
require_relative '../responses/lat_lon_list'

module NoaaClient
  module Services
    class ZipCodeToLatLon
      include RestService

      URL = "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?listZipCodeList="

      def initialize(options = {})
        @options = options
      end

      def convert(zip, options = {})
        rest_service.object_from_response(:get, build_url(zip), response_class: response_class)
      end

      private

      attr_reader :options

      def rest_service
        options.fetch(:rest_service, self)
      end

      def response_class
        options.fetch(:response_class, Responses::LatLonList)
      end

      def build_url(zip)
        "#{URL}#{zip}"
      end
    end
  end
end
