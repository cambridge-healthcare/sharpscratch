require_relative '../test_helper'
require_relative '../fixtures/procedure'
require 'rack/test'

require 'api/procedures'

module NHSHackDay
  module API
    describe Procedures do
      include Fixtures
      include Rack::Test::Methods

      def app
        Procedures
      end

      def body
        MultiJson.load(last_response.body, :symbolize_keys => true)
      end

      before do
        Procedure.conn.redis.flushdb
      end

      describe "GET /procedures" do
        describe "when no procedure exists" do
          it "returns an empty array with status 200" do
            get("/procedures")
            last_response.status.must_equal 200
            body.must_equal []
          end
        end

        describe "when procedure exists" do
          before do
            @procedure = seed.(lumbar_puncture)
          end

          it "returns all procedures as array with status 200" do
            get("/procedures")
            last_response.status.must_equal 200
            body.sample[:id].must_equal @procedure.id
          end
        end
      end

      describe "GET /procedures/:id" do
        describe "when procedure does not exist" do
          it "returns empty body with status 204" do
            get("/procedures/0")
            last_response.headers['X-Reason'].must_equal 'record could not be found'
            last_response.status.must_equal 204
          end
        end

        describe "when procedure exists" do
          before do
            @procedure = seed.(lumbar_puncture)
          end

          it "returns procedure with status 200" do
            get("/procedures/#{@procedure.id}")
            last_response.status.must_equal 200
            body[:id].must_equal @procedure.id
          end
        end
      end

      describe "POST /procedures" do
        describe "when procedure does not exist" do
          it "creates a new one and returns status 201" do
            post("/procedures", :title => lumbar_puncture[:title])
            last_response.status.must_equal 201
            body.keys.must_include :id
          end
        end

        describe "when procedure exists" do
          before do
            seed.(lumbar_puncture)
          end

          it "won't create a new one and returns status 403" do
            post("/procedures", :title => lumbar_puncture[:title])
            last_response.headers['X-Reason'].must_equal 'procedure already exists'
            last_response.status.must_equal 403
          end
        end
      end

      describe "GET /search" do
        before do
          @matching = seed.(lumbar_puncture)
          @non_matching = seed.(arterial_sampling)
        end

        describe "when term does not match" do
          it "returns empty array with status 200" do
            get("/search/foo")
            last_response.status.must_equal 200
            body.must_equal []
          end
        end

        describe "when term matches" do
          it "returns procedures with status 200" do
            get("/search/lumbar")
            last_response.status.must_equal 200
            body.map { |p| p[:title] }.must_equal [@matching.title]
          end
        end
      end
    end
  end
end
