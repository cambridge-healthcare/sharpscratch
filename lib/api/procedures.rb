require 'grape'

require_relative '../nhs_hack_day'
require_relative 'helpers'

module NHSHackDay
  module API
    class Procedures < Grape::API
      include Helpers

      default_format :json
      format :json

      rescue_from Model::NotFoundError do
        rack_response("", 204, 'X-Reason' => "record could not be found")
      end

      helpers Helpers

      namespace :procedures do
        desc "Returns a list of all procedures"
        get '/' do
          Procedure.all.map(&:attributes)
        end

        desc "Returns a single procedure"
        params do
          requires :procedure_id, :type => Integer, :desc => "Procedure identifier"
        end
        get '/:procedure_id' do
          procedure.attributes
        end

        desc "Creates a new procedure"
        params do
          requires :title, :type => String, :desc => "Procedure title"
        end
        post '/' do
          begin
            Procedure.create(
              :title => params[:title]
            ).attributes
          rescue Ohm::UniqueIndexViolation
            already_exists('procedure already exists')
          end
        end
      end

      namespace :search do
        desc "Searches across all procedure titles"
        params do
          requires :term, :type => String, :desc => "Search term"
        end
        get '/:term' do
          Procedure.all.select { |p|
            p.title.index(/#{params[:term]}/i)
          }.map(&:attributes)
        end
      end
    end
  end
end
