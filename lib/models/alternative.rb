require_relative 'model'

class Alternative < Ohm::Model
  attribute :what_to_do
  attribute :what_to_say

  reference :step, :Step
  set :votes, :Vote
end
