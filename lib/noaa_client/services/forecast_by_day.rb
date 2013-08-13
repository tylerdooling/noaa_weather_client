require_relative 'soap_service'
require_relative '../responses/forecast'

module NoaaClient
  module Services
    class ForecastByDay
      include SoapService

      def initialize(options = {})
        @options = options
      end

      def fetch(lat, lon, options = {})
        fopts = build_formated_options options.merge({ latitude: lat.to_s, longitude: lon.to_s })
        soap_service.object_from_response(:ndf_dgen_by_day, fopts, response_class: response_class)
      end

      private

      attr_reader :options

      def soap_service
        options.fetch(:soap_service, self)
      end

      def response_class
        options.fetch(:response_class, Responses::Forecast)
      end

      def build_formated_options(options)
        opts = options.dup
        {
          latitude: opts.delete(:latitude),
          longitude: opts.delete(:longitude),
          startDate: opts.delete(:start_date) { Date.today.to_s },
          numDays: opts.delete(:days) { 7 },
          unit: opts.delete(:unit) { 'e' },
          format: opts.delete(:format) { '24 hourly' }
        }.merge!(opts)
      end
    end
  end
end
