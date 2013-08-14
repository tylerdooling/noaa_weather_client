
require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_client/responses/current_observation'

module NoaaClient
  module Responses
    describe CurrentObservation do
      let(:current_observation) { CurrentObservation.new CURRENT_OBSERVATION_XML }

      it "requires a response" do
        current_observation
        expect { CurrentObservation.new }.to raise_error(ArgumentError)
      end

      it "exposes location" do
        expect(current_observation.location).to eq('Springfield-Branson National Airport, MO')
      end
      it "exposes station_id" do
        expect(current_observation.station_id).to eq('KSGF')
      end
      it "exposes latitude" do
        expect(current_observation.latitude).to eq('37.23')
      end
      it "exposes longitude" do
        expect(current_observation.longitude).to eq('-93.38')
      end
      it "exposes observation_time" do
        expect(current_observation.observation_time).to eq('Last Updated on Aug 12 2013, 2:52 pm CDT')
      end
      it "exposes observation_time_rfc822" do
        expect(current_observation.observation_time_rfc822).to eq('Mon, 12 Aug 2013 14:52:00 -0500')
      end
      it "exposes weather" do
        expect(current_observation.weather).to eq('Fair')
      end
      it "exposes temperature_string" do
        expect(current_observation.temperature_string).to eq('76.0 F (24.4 C)')
      end
      it "exposes temp_f" do
        expect(current_observation.temp_f).to eq('76.0')
      end
      it "exposes temp_c" do
        expect(current_observation.temp_c).to eq('24.4')
      end
      it "exposes relative_humidity" do
        expect(current_observation.relative_humidity).to eq('77')
      end
      it "exposes wind_string" do
        expect(current_observation.wind_string).to eq('West at 6.9 MPH (6 KT)')
      end
      it "exposes wind_dir" do
        expect(current_observation.wind_dir).to eq('West')
      end
      it "exposes wind_degrees" do
        expect(current_observation.wind_degrees).to eq('290')
      end
      it "exposes wind_mph" do
        expect(current_observation.wind_mph).to eq('6.9')
      end
      it "exposes wind_kt" do
        expect(current_observation.wind_kt).to eq('6')
      end
      it "exposes pressure_string" do
        expect(current_observation.pressure_string).to eq('1015.4 mb')
      end
      it "exposes pressure_mb" do
        expect(current_observation.pressure_mb).to eq('1015.4')
      end
      it "exposes pressure_in" do
        expect(current_observation.pressure_in).to eq('30.02')
      end
      it "exposes dewpoint_string" do
        expect(current_observation.dewpoint_string).to eq('68.0 F (20.0 C)')
      end
      it "exposes dewpoint_f" do
        expect(current_observation.dewpoint_f).to eq('68.0')
      end
      it "exposes dewpoint_c" do
        expect(current_observation.dewpoint_c).to eq('20.0')
      end
      it "exposes visibility_mi" do
        expect(current_observation.visibility_mi).to eq('10.00')
      end
      it "exposes icon_url_base" do
        expect(current_observation.icon_url_base).to eq('http://forecast.weather.gov/images/wtf/small/')
      end
      it "exposes two_day_history_url" do
        expect(current_observation.two_day_history_url).to eq('http://www.weather.gov/data/obhistory/KSGF.html')
      end
      it "exposes icon_url_name" do
        expect(current_observation.icon_url_name).to eq('skc.png')
      end
      it "exposes ob_url" do
        expect(current_observation.ob_url).to eq('http://www.weather.gov/data/METAR/KSGF.1.txt')
      end
      it "exposes disclaimer_url" do
        expect(current_observation.disclaimer_url).to eq('http://weather.gov/disclaimer.html')
      end
      it "exposes copyright_url" do
        expect(current_observation.copyright_url).to eq('http://weather.gov/disclaimer.html')
      end
      it "exposes privacy_policy_url" do
        expect(current_observation.privacy_policy_url).to eq('http://weather.gov/notice.html')
      end

      it "provides a shortcut to return a list of attributes as a hash" do
        attrs = [ :temp_f, :location, :weather ]
        expect(current_observation.to_hash(attrs)).to eq(Hash[attrs.map { |a| [ a, current_observation.send(a) ] }])
      end

      CURRENT_OBSERVATION_XML = <<-RESPONSE

<?xml version="1.0" encoding="ISO-8859-1"?> 
<?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>
<current_observation version="1.0"
   xmlns:xsd="http://www.w3.org/2001/XMLSchema"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:noNamespaceSchemaLocation="http://www.weather.gov/view/current_observation.xsd">
  <credit>NOAA's National Weather Service</credit>
  <credit_URL>http://weather.gov/</credit_URL>
  <image>
    <url>http://weather.gov/images/xml_logo.gif</url>
    <title>NOAA's National Weather Service</title>
    <link>http://weather.gov</link>
  </image>
  <suggested_pickup>15 minutes after the hour</suggested_pickup>
  <suggested_pickup_period>60</suggested_pickup_period>
  <location>Springfield-Branson National Airport, MO</location>
  <station_id>KSGF</station_id>
  <latitude>37.23</latitude>
  <longitude>-93.38</longitude>
  <observation_time>Last Updated on Aug 12 2013, 2:52 pm CDT</observation_time>
        <observation_time_rfc822>Mon, 12 Aug 2013 14:52:00 -0500</observation_time_rfc822>
  <weather>Fair</weather>
  <temperature_string>76.0 F (24.4 C)</temperature_string>
  <temp_f>76.0</temp_f>
  <temp_c>24.4</temp_c>
  <relative_humidity>77</relative_humidity>
  <wind_string>West at 6.9 MPH (6 KT)</wind_string>
  <wind_dir>West</wind_dir>
  <wind_degrees>290</wind_degrees>
  <wind_mph>6.9</wind_mph>
  <wind_kt>6</wind_kt>
  <pressure_string>1015.4 mb</pressure_string>
  <pressure_mb>1015.4</pressure_mb>
  <pressure_in>30.02</pressure_in>
  <dewpoint_string>68.0 F (20.0 C)</dewpoint_string>
  <dewpoint_f>68.0</dewpoint_f>
  <dewpoint_c>20.0</dewpoint_c>
  <visibility_mi>10.00</visibility_mi>
  <icon_url_base>http://forecast.weather.gov/images/wtf/small/</icon_url_base>
  <two_day_history_url>http://www.weather.gov/data/obhistory/KSGF.html</two_day_history_url>
  <icon_url_name>skc.png</icon_url_name>
  <ob_url>http://www.weather.gov/data/METAR/KSGF.1.txt</ob_url>
  <disclaimer_url>http://weather.gov/disclaimer.html</disclaimer_url>
  <copyright_url>http://weather.gov/disclaimer.html</copyright_url>
  <privacy_policy_url>http://weather.gov/notice.html</privacy_policy_url>
</current_observation>
      RESPONSE

    end
  end
end
