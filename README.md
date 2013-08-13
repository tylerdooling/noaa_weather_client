# NoaaClient

Ruby wrapper for the noaa weather api.

## Installation

Add this line to your application's Gemfile:

    gem 'noaa_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install noaa_client

## Usage

```ruby
client = NoaaClient.build_client

# convert zip to lat/lon
coordinate = client.zip_code_to_lat_lon(90210)

# 7 day forecast
client.forecast_by_day(coordinate.latitude, coordinate.longitude)

# nearest_weather_station
client.nearest_weather_station(coordinate.latitude, coordinate.longitude)

# all weather stations
client.nearest_weather_station(coordinate.latitude, coordinate.longitude)

# current observations
client.current_observations(coordinate.latitude, coordinate.longitude)
```
