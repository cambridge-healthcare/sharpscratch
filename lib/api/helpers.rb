module NHSHackDay
  module API
    module Helpers
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
  end
end
