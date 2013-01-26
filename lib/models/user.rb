require_relative 'model'

class User < Ohm::Model
  include Model

  attribute :first_name
  attribute :last_name
  attribute :nickname
  attribute :professional
  collection :procedures, :Procedure

  def nickname
    "#{first_name}.#{last_name}".downcase
  end

  unique :nickname
end
