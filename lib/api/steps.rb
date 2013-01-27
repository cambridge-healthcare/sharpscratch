require 'grape'

require_relative '../nhs_hack_day'
require_relative 'helpers'

module NHSHackDay
  module API
    class Steps < Grape::API
      default_format :json
      format :json

      rescue_from Model::NotFoundError do
        rack_response("", 204, 'X-Reason' => "record could not be found")
      end

      helpers Helpers

      namespace :procedures do
        desc "Returns a list of all steps"
        params do
          requires :procedure_id, :type => Integer, :desc => "Procedure identifier"
        end
        get '/:procedure_id/steps' do
          procedure.steps.map(&:attributes)
        end
      end

      namespace :steps do
        desc "Returns a single step"
        params do
          requires :step_id, :type => Integer, :desc => "Step identifier"
        end
        get '/:step_id' do
          step.attributes
        end

        desc "Creates a new step"
        params do
          requires :title, :type => String, :desc => "Step title"
          requires :procedure_id, :type => Integer, :desc => "Procedure identifier to which this step belongs to"
          optional :to_do, :type => String, :desc => "What to do during this step"
          optional :to_say, :type => String, :desc => "What to say to the patient"
        end
        post '/' do
          begin
            Step.create(
              :title        => params[:title],
              :to_do        => params[:to_do],
              :to_say       => params[:to_say],
              :procedure_id => params[:procedure_id]
            ).attributes
          rescue Ohm::UniqueIndexViolation
            already_exists('step already exists')
          end
        end
      end
    end
  end
end
