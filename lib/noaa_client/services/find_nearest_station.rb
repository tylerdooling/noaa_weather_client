require_relative 'calculate_distance_between_lat_lon'

module NoaaClient
  module Services
    module FindNearestStation
      def self.find(lat, lon, stations, options = {})
        calc = options.fetch(:calculator, CalculateDistanceBetweenLatLon)
        distances = stations.map { |s| calc.get_distance(lat, lon, s.latitude, s.longitude) }
        stations.fetch distances.find_index(distances.min)
      end
    end
  end
end
