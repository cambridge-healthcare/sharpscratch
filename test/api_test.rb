require_relative 'test_helper'
require 'rack/test'

require 'api'

def lumbar_puncture
  {
    :name  => "lumbar-puncture",
    :title => "Lumbar Puncture"
  }
end

def arterial_black_guess_sampling
  {
    :name  => "arterial-black-guess-sampling",
    :title => "Arterial Black Guess Sampling"
  }
end

def new_procedure(hash)
  Procedure.create(hash)
end

module NHSHackDay
  describe API do
    include Rack::Test::Methods

    def app
      NHSHackDay::API
    end

    def body
      MultiJson.load(last_response.body, :symbolize_keys => true)
    end

    before do
      Procedure.conn.redis.flushdb
    end

    describe "GET /procedures/:id" do
      describe "when procedure does not exist" do
        it "returns 404" do
          get("/procedures/0")
          last_response.headers['X-Reason'].must_equal 'procedure could not be found'
          last_response.status.must_equal 404
        end
      end

      describe "when procedure exists" do
        before do
          @procedure = new_procedure(lumbar_puncture)
        end

        it "returns procedure as JSON" do
          get("/procedures/#{@procedure.id}")
          last_response.status.must_equal 200
          body.must_equal @procedure.attributes
        end
      end
    end

    describe "POST /procedures" do
      describe "when procedure does not exist" do
        it "creates a new one" do
          post("/procedures", lumbar_puncture)
          last_response.status.must_equal 201
        end
      end

      describe "when procedure exists" do
        before do
          new_procedure(lumbar_puncture)
        end

        it "won't create a new one" do
          post("/procedures", lumbar_puncture)
          last_response.headers['X-Reason'].must_equal 'procedure already exists'
          last_response.status.must_equal 403
        end
      end
    end

    describe "GET /search" do
      before do
        @matching = new_procedure(lumbar_puncture)
        @non_matching = new_procedure(arterial_black_guess_sampling)
      end
      it "returns procedures where name matches" do
        get("/search/lumbar")
        last_response.status.must_equal 200
        body.map { |p| p[:title] }.must_equal [@matching.title]
      end
    end
  end
end
