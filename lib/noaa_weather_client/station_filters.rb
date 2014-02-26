module NoaaWeatherClient
  module StationFilters
    def self.icao
      ->(station) { (station.station_id =~ /\A[A-Z|0-9]{4}\z/) ? true : false }
    end
  end
end
