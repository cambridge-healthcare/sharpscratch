require 'grape'
require 'grape-swagger'
require 'oj'
require 'pry' if ENV['RACK_ENV'] == "development"

require_relative 'models/procedure'

Oj.mimic_JSON

module NHSHackDay
  class API < Grape::API
    VERSION = "0.1"

    helpers do
      def not_found(message)
        status 404
        header "X-Reason", message
        body nil
      end

      def no_content(message)
        status 204
        header "X-Reason", message
        body nil
      end

      def already_exists(message)
        status 403
        header "X-Reason", message
        body nil
      end
    end

    namespace :procedures do
      get '/:id' do
        not_found('procedure could not be found')
      end
    end
  end

  # For the API endpoints to show up in swagger, we need to do `mount API`.
  class Root < Grape::API
    default_format :json
    format :json

    add_swagger_documentation(
      :api_version             => API::VERSION,
      :hide_documentation_path => true,
      :markdown                => true
    )

    mount API
  end
end
