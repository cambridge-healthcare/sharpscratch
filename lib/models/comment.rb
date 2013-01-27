require_relative 'model'

class Comment < Ohm::Model
  attribute :text
  reference :user, :User
  reference :step, :Step
end
