require_relative 'model'

class Vote < Ohm::Model
  reference :user, :User
  reference :alternative, :Alternative
  reference :consent, :Consent
end
