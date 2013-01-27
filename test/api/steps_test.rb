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
        @procedure = seed.(central_venous_catheterisation)
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

      #describe "POST /procedures" do
        #describe "when procedure does not exist" do
          #it "creates a new one and returns status 201" do
            #post("/procedures", lumbar_puncture)
            #last_response.status.must_equal 201
            #body.keys.must_include :id
          #end
        #end

        #describe "when procedure exists" do
          #before do
            #new_procedure(lumbar_puncture)
          #end

          #it "won't create a new one and returns status 403" do
            #post("/procedures", lumbar_puncture)
            #last_response.headers['X-Reason'].must_equal 'procedure already exists'
            #last_response.status.must_equal 403
          #end
        #end
      #end
    end
  end
end
