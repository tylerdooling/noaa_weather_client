require_relative '../xml_parser_factory'
require_relative 'reactive_xml_response'
require_relative 'validatable_xml_response'

module NoaaWeatherClient
  module Responses
    class CurrentObservation
      include ReactiveXmlResponse
      include ValidatableXmlResponse

      def initialize(response)
        @source = XmlParserFactory.build_parser.parse response
        validate! @source, :current_observation
        init
      end

      def temperature_celsius
        @temp_c.to_f
      end

      def temperature_fahrenheit
        @temp_f.to_f
      end

      def dewpoint_celsius
        @dewpoint_c.to_f
      end

      def dewpoint_fahrenheit
        @dewpoint_f.to_f
      end

      def latitude
        @latitude.to_f
      end

      def longitude
        @longitude.to_f
      end

      def observation_time_string
        @observation_time
      end

      def observation_time
        Time.parse(@observation_time_rfc822.to_s) if @observation_time_rfc822
      end

      def pressure_in
        @pressure_in.to_f
      end

      def pressure_mb
        @pressure_mb.to_f
      end

      def relative_humidity
        @relative_humidity.to_f
      end

      def wind_degrees
        @wind_degrees.to_f
      end

      def wind_kt
        @wind_kt.to_f
      end

      def wind_mph
        @wind_mph.to_f
      end

      def visibility_mi
        @visibility_mi.to_f
      end

      def to_hash
        arr = instance_variables.map { |v|
          [ v.to_s[1..-1], instance_variable_get(v) ] unless v =~ /source/
        }.compact
        Hash[arr]
      end

      private

      def init
        source.root.elements.each do |e|
          instance_variable_set("@#{e.name}", e.text)
        end
      end
    end
  end
end
