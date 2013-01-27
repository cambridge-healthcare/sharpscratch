module Fixtures
  module Procedure
    extend self

    def all
      [
        lumbar_puncture,
        arterial_blood_gas_sampling
      ]
    end

    def lumbar_puncture
      {
        :title => "Lumbar Puncture"
      }
    end

    def arterial_blood_gas_sampling
      {
        :title => "Arterial Blood Gas Sampling"
      }
    end
  end
end
