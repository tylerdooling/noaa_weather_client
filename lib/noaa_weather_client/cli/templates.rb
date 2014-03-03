module NoaaWeatherClient
  module Templates
    CurrentObservations = Struct.new(:observation) do
      def to_s
        <<-template
Current Observations
================================================================================
StationID: #{observation.station_id}
Station Name: #{observation.location}
Location: #{observation.latitude}, #{observation.longitude}
Observation Time: #{observation.observation_time_string}
Temperature: #{observation.temperature_fahrenheit} | #{observation.temperature_celsius}
Dewpoint: #{observation.dewpoint_fahrenheit} | #{observation.dewpoint_celsius}
Pressure: #{observation.pressure_in} in | #{observation.pressure_mb} mb
Humidity: #{observation.relative_humidity}
Wind: #{observation.wind_string}
Wind Direction: #{observation.wind_dir} | #{observation.wind_degrees} degrees
Wind Speed: #{observation.wind_mph} mph | #{observation.wind_kt} kt
Visibility: #{observation.visibility_mi} mi

template
      end
    end

    PostalCode = Struct.new(:coordinate) do
      def to_s
        "#{coordinate.latitude} #{coordinate.longitude}"
      end
    end

    ForecastDay = Struct.new(:day) do
      def to_s
        <<-template
Day: #{day.name}
--------------------------------------------------------------------------------
High: #{day.maximum_temperature} F
Low: #{day.minimum_temperature} F
Summary: #{day.weather_summary}

template
      end
    end

    Forecast = Struct.new(:forecast) do
      def to_s
        template = "\n#{forecast.days.size}-Day Forecast\n"
        template += "================================================================================\n"
        forecast.days.each { |d| template +=  ForecastDay.new(d).to_s }
        template
      end
    end
  end
end
