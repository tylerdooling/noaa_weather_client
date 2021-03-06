require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'simplecov'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

module Helpers
  def load_xml_fixture(name)
    File.read(File.expand_path(File.join('..', 'fixtures', 'xml', "#{name.to_s}.xml"), __FILE__))
  end
end

RSpec.configure do |config|
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  # --seed 1234
  config.order = "random"
  config.formatter = :documentation
  config.mock_with :rspec
  config.include Helpers
end

SimpleCov.start do
  add_filter "/spec/"
end

