require 'grape'
require 'grape-swagger'
require 'pry' if ENV['RACK_ENV'] == "development"

require_relative 'nhs_hack_day'

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

      def procedure
        if p = Procedure[params[:procedure_id]]
          p.attributes
        end
      end
    end

    namespace :procedures do
      desc "Returns a single procedure"
      params do
        requires :procedure_id, :type => Integer, :desc => "Procedure identifier"
      end
      get '/:procedure_id' do
        procedure or not_found('procedure could not be found')
      end

      desc "Creates a new procedure"
      params do
        requires :name, :type => String, :desc => "URL-friendly procedure name"
        requires :title, :type => String, :desc => "Human friendly procedure name"
      end
      post '/' do
        begin
          Procedure.create(
            :name  => params[:name],
            :title => params[:title]
          ).attributes
        rescue Ohm::UniqueIndexViolation
          already_exists('procedure already exists')
        end
      end
    end

    namespace :search do
      desc "Searches across all procedure names"
      params do
        requires :term, :type => String, :desc => "Search term"
      end
      get '/:term' do
        Procedure.all.select { |p|
          p.name.index(/#{params[:term]}/i)
        }.map(&:attributes)
      end
    end
  end

  # For the API endpoints to show up in swagger, we need to do `mount API`.
  class Root < Grape::API
    default_format :json
    format :json

    before do
      header "Access-Control-Allow-Origin", "*"
    end

    add_swagger_documentation(
      :api_version             => API::VERSION,
      :hide_documentation_path => true,
      :markdown                => true,
      :mount_path              => '/doc'
    )

    mount API
  end
end
