module Fixtures
  module Procedures
    extend self

    def all
      [
        lumbar_puncture,
        arterial_black_guess_sampling
      ]
    end

    def lumbar_puncture
      {
        :title => "Lumbar Puncture"
      }
    end

    def arterial_black_guess_sampling
      {
        :title => "Arterial Black Guess Sampling"
      }
    end
  end
end
