require_relative 'model'

class Consent < Ohm::Model
  attribute :text
  set :votes, :Vote
  collection :alternatives, :Alternative
  collection :comments, :Comment
  collection :complications, :Complication
end
