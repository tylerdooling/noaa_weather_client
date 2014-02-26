module NoaaWeatherClient
  module Services
    module CalculateDistanceBetweenLatLon
      extend Math

      def self.get_distance(lat1, lon1, lat2, lon2)
        lat1, lon1, lat2, lon2 = convert_to_radian(lat1, lon1, lat2, lon2)

        radius = 6371 #km
        s = sin(lat1) * sin(lat2)
        c = cos(lat1) * cos(lat2) * cos(lon2-lon1)
        acos(s + c) * radius;
      end

      def self.convert_to_radian(*args)
        args.map { |arg| arg / 180 * Math::PI }
      end
    end
  end
end
