require_relative 'model'

class Comment < Ohm::Model
  attribute :text
  reference :user, :User
  reference :step, :Step
  # Can we have more than one references?
  reference :complication, :Complication
  reference :consent, :Consent
end
