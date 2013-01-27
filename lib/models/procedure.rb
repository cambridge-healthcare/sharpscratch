require_relative 'model'

class Procedure < Ohm::Model
  include Model

  attribute :title
  attribute :snomed_id
  attribute :consent
  attribute :materials
  attribute :precautions
  collection :steps, :Step
  reference :user, :User

  unique :title
end
