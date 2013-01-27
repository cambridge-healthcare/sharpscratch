require_relative '../test_helper'
require_relative '../fixtures/procedure'
require 'rack/test'

require 'api/steps'

module NHSHackDay
  module API
    describe Step do
      include Fixtures
      include Rack::Test::Methods

      def app
        Steps
      end

      def body
        MultiJson.load(last_response.body, :symbolize_keys => true)
      end

      before do
        Step.conn.redis.flushdb
        @procedure = seed.(cannular_insertion)
      end

      describe "GET /steps" do
        describe "when no steps exist for a given procedure" do
          it "returns an empty array with status 200" do
            get("/procedures/#{@procedure.id}/steps")
            last_response.status.must_equal 200
            body.must_equal []
          end
        end

        describe "when steps exist" do
          before do
            @procedure = seed.(lumbar_puncture)
          end

          it "returns all procedures as array with status 200" do
            get("/procedures/#{@procedure.id}/steps")
            last_response.status.must_equal 200
            body.sample.keys.must_equal [:title, :procedure_id, :id]
          end
        end
      end

      describe "GET /steps/:id" do
        describe "when step does not exist" do
          it "returns empty body with status 404" do
            get("/steps/0")
            last_response.headers['X-Reason'].must_equal 'record could not be found'
            last_response.status.must_equal 204
          end
        end

        describe "when step exists" do
          before do
            procedure = seed.(lumbar_puncture)
            @step = procedure.steps.to_a.sample
          end

          it "returns procedure with status 200" do
            get("/steps/#{@step.id}")
            last_response.status.must_equal 200
            body.must_equal @step.attributes
          end
        end
      end

      describe "POST /steps" do
        it "creates a new one and returns status 201" do
          post("/steps", :title => "Step 1", :procedure_id => @procedure.id)
          last_response.status.must_equal 201
          body[:procedure_id].must_equal @procedure.id.to_i
          body[:title].must_equal "Step 1"
        end
      end
    end
  end
end
