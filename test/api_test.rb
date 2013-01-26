require_relative 'test_helper'
require_relative 'fixtures/procedures'
require 'rack/test'

require 'api'

module NHSHackDay
  module API
    describe Root do
      include Rack::Test::Methods

      def app
        NHSHackDay::Root
      end

      def body
        MultiJson.load(last_response.body, :symbolize_keys => true)
      end
    end
  end
end
