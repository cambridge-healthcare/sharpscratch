require_relative 'model'

class Procedure < Ohm::Model
  include Model

  attribute :name
  attribute :title
  attribute :snomed_id
  collection :steps, :Step
  reference :user, :User

  unique :name
end
