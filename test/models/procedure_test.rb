require_relative '../test_helper'

require 'models/procedure'

describe Procedure do
  it "includes :id in attributes" do
    Procedure.create.attributes.must_include :id
  end
end
