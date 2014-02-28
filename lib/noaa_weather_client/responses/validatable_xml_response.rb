module NoaaWeatherClient
  module Responses
    module ValidatableXmlResponse
      SCHEMA_PATH = File.expand_path("../../../../data/xml", __FILE__)
      class InvalidXmlError < ArgumentError; end

      def validate!(doc, schema_name)
        # chdir to help Nokogiri load included schemas
        Dir.chdir(SCHEMA_PATH) do
          schema_file = File.join(SCHEMA_PATH, "#{schema_name}.xsd")
          schema = Nokogiri::XML::Schema(File.read(schema_file))
          errors = schema.validate(doc)
          unless errors.empty?
            raise InvalidXmlError, "Invalid xml: #{errors.map(&:message).join("\n")}"
          end
        end
      end
    end
  end
end

