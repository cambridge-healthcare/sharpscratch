require_relative 'model'

class User < Ohm::Model
  attribute :first_nane
  attribute :last_name
  attribute :professional
  collection :procedures, :Procedure
end
