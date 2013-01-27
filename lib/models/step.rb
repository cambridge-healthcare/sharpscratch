require_relative 'model'

class Step < Ohm::Model
  include Model

  attribute :title
  attribute :to_do
  attribute :to_say
  collection :comments, :Comment
  reference :procedure, :Procedure
end
