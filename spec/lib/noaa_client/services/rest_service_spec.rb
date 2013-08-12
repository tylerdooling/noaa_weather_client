require_relative '../../../spec_helper'
require_relative '../../../../lib/noaa_client/services/rest_service'

module NoaaClient
  module Services
    describe RestService do
      let(:fake_response) { double(body: 'fake_response_body') }
      let(:mock_client) { double(request: fake_response) }
      let(:mock_response_class) { double(new: nil) }
      let(:implementer) { Class.new { include RestService }.new }
      let(:args) { [ :get, 'http://www.google.com', { client: mock_client } ] }

      context "#object_from_response" do
        it "requires an action and url" do
          implementer.object_from_response :get, 'http://www.google.com', client: mock_client
          expect { implementer.object_from_response }.to raise_error(ArgumentError)
        end

        it "accepts an options hash" do
          implementer.object_from_response :get, 'http://www.google.com', client: mock_client
        end

        it "builds a request from the args" do
          expect(implementer).to receive(:build_request_for_action).with(*args)
          implementer.object_from_response(*args)
        end

        it "passes the rest response to the response class" do
          expect(mock_client).to receive(:request).and_return(fake_response)
          expect(mock_response_class).to receive(:new).with(fake_response.body)
          action, url, opts = *args
          implementer.object_from_response(action, url, opts.merge(response_class: mock_response_class))
        end

        it "returns a new wrapped response body" do
          expect(mock_response_class).to receive(:new).with(fake_response.body).and_return(mock_response_class)
          action, url, opts = *args
          expect(
            implementer.object_from_response(action, url, opts.merge(response_class: mock_response_class))
          ).to eq(mock_response_class)
        end
      end
    end
  end
end
