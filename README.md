# NoaaWeatherClient

Ruby wrapper for the NOAA weather api.

## Installation

Add this line to your application's Gemfile:

    gem 'noaa_weather_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install noaa_weather_client


## Notes

### Weather Station Caching

It is important to cache a copy of the available stations for use here, as the xml stations response is quite large noaa does not appreciate repeated calls.

```ruby
# cache a copy of stations and store in memory, file, etc.
stations = client.nearest_weather_station(coordinate.latitude, coordinate.longitude)

# current_observations
client.current_observations(some_lat, some_lon, stations: stations)

# nearest_weather_station
client.nearest_weather_station(some_lat, some_lon, stations: stations)
```

## Usage

```ruby
client = NoaaWeatherClient.build_client

# all weather stations
client.weather_stations

# nearest_weather_station
client.nearest_weather_station(coordinate.latitude, coordinate.longitude)

# convert zip to lat/lon
coordinate = client.zip_code_to_lat_lon(90210)

# 7 day forecast
client.forecast_by_day(coordinate.latitude, coordinate.longitude)

# current observations
client.current_observations(coordinate.latitude, coordinate.longitude)
```
