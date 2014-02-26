require_relative 'calculate_distance_between_lat_lon'

module NoaaWeatherClient
  module Services
    module FindNearestStation
      def self.find(lat, lon, stations, options = {})
        calc = options.fetch(:calculator, CalculateDistanceBetweenLatLon)
        filter = options.fetch(:filter, nil)
        count = options.fetch(:count, 1)
        stations.select!(&filter) if filter
        stations.sort_by! { |s| calc.get_distance(lat, lon, s.latitude, s.longitude) }
        count == 1 ? stations.first : stations.take(count)
      end
    end
  end
end
