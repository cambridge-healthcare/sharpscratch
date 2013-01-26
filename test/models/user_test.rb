require_relative '../test_helper'
require_relative '../fixtures/user'

require 'models/user'

describe User do
  include Fixtures::User

  it "cannot create duplicates - only because of virtual attributes" do
    User.create(arnold)
    ->{ User.create(arnold) }.must_raise Ohm::UniqueIndexViolation
  end
end
