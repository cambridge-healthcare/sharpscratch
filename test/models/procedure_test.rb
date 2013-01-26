require_relative '../test_helper'

require 'models/procedure'

describe Procedure do
  it "is an Ohm::Model" do
    Procedure.ancestors.must_include Ohm::Model
  end
end
