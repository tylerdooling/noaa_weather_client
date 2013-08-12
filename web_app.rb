require 'sinatra'
require 'haml'
require_relative 'lib/noaa_client'

get '/forecast' do
  client = NoaaClient.build_client
  @forecast = client.forecast_by_day 37.1962, -93.2861
  haml :forecast
end
