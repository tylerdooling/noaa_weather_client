[![Build Status](https://travis-ci.org/tylerdooling/noaa_weather_client.png)](https://travis-ci.org/tylerdooling/noaa_weather_client)
# NoaaWeatherClient

Ruby wrapper for the NOAA weather API.

## Installation

Add this line to your application's Gemfile:

    gem 'noaa_weather_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install noaa_weather_client


## Notes

### Weather Station Caching

It is important to cache a copy of the available stations for frequent use as the stations response is quite large NOAA does not appreciate repeated calls.

```ruby
# cache a copy of stations and store in memory, file, etc.
stations = client.weather_stations

# current_observations
client.current_observations(some_lat, some_lon, stations: stations)

# nearest_weather_station
client.nearest_weather_station(some_lat, some_lon, stations: stations)

```
#### Filtering Weather Stations
In my experience, the best observations tend to come from the
ICAO(mostly airports) stations.  There are many other stations -
typically in cities and near the coast, but the observations tend to be
partial and intermittent.

```ruby
# filter by station type
filter = NoaaWeatherClient::StationFilters.icao
client.nearest_weather_station(some_lat, some_lon, stations: stations, filter: filter)
```

### Postal Codes
NOAA provides a service to resolve postal codes to a coordinate.

```ruby
# convert postal code to coordinate
coordinate = client.postal_code_to_coordinate(90210)
coordinate.latitude #=> 34.0995
coordinate.longitude #=> -118.414
```

## Usage
```ruby
# create a client instance
client = NoaaWeatherClient.build_client

# all weather stations
client.weather_stations

# locate the nearest weather station
client.nearest_weather_station(34.0995, -118.414)

# 7 day forecast
client.forecast_by_day(34.0995, -118.414)

# current observations
client.current_observations(34.0995, -118.414)
```

## Contributing
Contributions are always welcome. A few notes:

* Keep changes small and on topic.
* Stay consistent with existing code conventions.
* Break changes into smaller logical commits.

To propose a change or fix a bug:

* [Fork the project.](https://help.github.com/articles/fork-a-repo)
* Make your feature addition or bug fix.
* Add tests for it.
* Commit.
* [Send a pull request](https://help.github.com/articles/using-pull-requests)

