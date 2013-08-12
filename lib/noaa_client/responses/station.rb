module NoaaClient
  module Responses
    class Station
      attr_reader :station_id, :station_name, :state, :latitude, :longitude, :xml_url

      def initialize(attributes = {})
        attributes.each { |k, v| instance_variable_set "@#{k}", v }
      end

      def latitude
        @latitude.to_f
      end

      def longitude
        @longitude.to_f
      end
    end
  end
end
