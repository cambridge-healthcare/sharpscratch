require_relative 'model'

class Step < Ohm::Model
  include Model

  attribute :title
  collection :alternatives, :Alternative
  collection :complications, :Complication
  collection :comments, :Comment
  reference :procedure, :Procedure
end
