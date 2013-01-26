require_relative 'test_helper'
require 'rack/test'

require 'api'

module NHSHackDay
  describe API do
    include Rack::Test::Methods

    def app
      NHSHackDay::API
    end

    def body
      Oj.load(last_response.body)
    end

    describe "GET /proceudre/:id" do
      describe "when procedure does not exist" do
        it "returns 404" do
          get("/procedures/0")
          last_response.headers['X-Reason'].must_equal 'procedure could not be found'
          last_response.status.must_equal 404
        end
      end
    end
  end
end
