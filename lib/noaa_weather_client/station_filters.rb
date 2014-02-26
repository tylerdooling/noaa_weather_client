module NoaaWeatherClient
  module StationFilters
    # {https://en.wikipedia.org/wiki/International_Civil_Aviation_Organization_airport_code ICAO reference}
    def self.icao
      ->(station) { (station.station_id =~ /\A[A-Z|0-9]{4}\z/) ? true : false }
    end
  end
end
