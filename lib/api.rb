require 'grape'
require 'grape-swagger'

require_relative 'nhs_hack_day'
require_relative 'api/procedures'

module NHSHackDay
  module API
    # For the API endpoints to show up in swagger, we need to do `mount API`.
    class Root < Grape::API
      VERSION = "0.1"

      default_format :json
      format :json

      before do
        header "Access-Control-Allow-Origin", "*"
      end

      add_swagger_documentation(
        :api_version             => VERSION,
        :hide_documentation_path => true,
        :markdown                => true,
        :mount_path              => '/doc'
      )

      mount Procedures
    end
  end
end
