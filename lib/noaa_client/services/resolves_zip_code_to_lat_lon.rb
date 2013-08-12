require_relative '../coordinate'
require_relative '../soap_client_factory'
require_relative '../xml_parser_factory'

module NoaaClient
  module Services
    class ResolvesZipCodeToLatLon
      def initialize(zip, options = {})
        @zip = zip
        @options = options
      end

      def resolve
        raw = fetch_raw_response
        lat, lon = parse_lat_lon raw
        coordinate_class.new lat, lon
      end

      private

      attr_reader :zip, :options

      def coordinate_class
        options.fetch(:coordinate_class, Coordinate)
      end

      def client_factory
        options.fetch(:client_factory, SoapClientFactory)
      end

      def fetch_raw_response
        begin
          soap = client_factory.build_client
          soap.call(:lat_lon_list_zip_code, message: { 'zipCodeList' => zip.to_s })
        rescue Savon::Error
        end
      end

      def parse_lat_lon(raw_response)
        payload = raw_response.body[:lat_lon_list_zip_code_response][:list_lat_lon_out]
        parsed = XmlParserFactory.build_parser.parse(payload)
        string_coord = parsed.css('latLonList').text
        string_coord.split(",").map { |s| s.to_f }
      rescue Savon::InvalidResponseError
      end
    end
  end
end
