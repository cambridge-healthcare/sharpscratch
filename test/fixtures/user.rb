module Fixtures
  module User
    extend self
    
    def all
      [
        arnold,
        elizabeth,
        lisa
      ]
    end

    def arnold
      {
        :first_name => "Arnold",
        :last_name => "Fraser"
      }
    end

    def elizabeth
      {
        :first_name => "Elizabeth",
        :last_name => "Frances"
      }
    end

    def lisa
      {
        :first_name => "Lisa",
        :last_name => "Cuddy",
        :professional => true
      }
    end
  end
end
