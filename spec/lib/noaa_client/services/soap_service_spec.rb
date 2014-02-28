require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_weather_client/services/soap_service'

module NoaaWeatherClient
  module Services
    describe SoapService do
      let(:fake_response) { double(body: 'fake_response_body') }
      let(:mock_client) { double(call: fake_response) }
      let(:mock_response_class) { double(new: nil) }
      let(:implementer) { Class.new { include SoapService }.new }

      context "#object_from_response" do
        it "requires a soap action and message" do
          implementer.object_from_response :soap_action, :message, client: mock_client
          expect { implementer.object_from_response }.to raise_error(ArgumentError)
        end

        it "accepts an options hash" do
          implementer.object_from_response :soap_action, :message, client: mock_client
        end

        it "calls the soap client with the soap action" do
          expect(mock_client).to receive(:call).with(:soap_action, anything)
          implementer.object_from_response :soap_action, :message, client: mock_client
        end

        it "calls the soap client with the message" do
          expect(mock_client).to receive(:call).with(anything, hash_including(message: :message))
          implementer.object_from_response :soap_action, :message, client: mock_client
        end

        it "passes the soap response to the response" do
          expect(mock_client).to receive(:call).and_return(fake_response)
          expect(mock_response_class).to receive(:new).with(fake_response.body)
          implementer.object_from_response :soap_action, :message, client: mock_client, response_class: mock_response_class
        end

        it "returns a new wrapped response body" do
          expect(mock_response_class).to receive(:new).with(fake_response.body).and_return(mock_response_class)
          expect(implementer.object_from_response(:soap_action,
                                                  :message,
                                                  client: mock_client,
                                                  response_class: mock_response_class)).to eq(mock_response_class)
        end

        context "when a Savon:Error occurs" do
          it "raises a CommunicationError" do
            allow(mock_client).to receive(:call).and_raise(Savon::Error)
            expect { implementer.object_from_response :soap_action, :message, client: mock_client }
              .to raise_error(Errors::CommunicationError)
          end
        end
      end
    end
  end
end
