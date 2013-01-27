module NHSHackDay
  module API
    module Helpers
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
        Procedure[params[:procedure_id]] or raise Procedure::NotFoundError
      end

      def step
        Step[params[:step_id]] or raise Step::NotFoundError
      end
    end
  end
end
