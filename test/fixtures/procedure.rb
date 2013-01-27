require 'ap'

module Fixtures
  extend self

  def seed
    Proc.new { |hash|
      begin
        procedure = Procedure.create(:title => hash[:title])
        hash[:steps].each do |step|
          Step.create(
            :title        => step,
            :procedure_id => procedure.id
          )
        end
        procedure
      rescue Ohm::UniqueIndexViolation
        puts "\n::: Already exists, skipping ".ljust(70, ":::")
        ap(hash, indent: -2)
      end
    }
  end

  def all_procedures
    [
      lumbar_puncture,
      arterial_sampling,
      cannular_insertion
    ]
  end

  def lumbar_puncture
    {
      :title     => "Lumbar Puncture",
      :snomed_id => 277762005,
      :steps     => [
        "Consent",
        "Preparing the materials",
        "Positioning the patient",
        "Identifying the area for procedure",
        "Cleaning",
        "Local Anaesthetic",
        "Introducing the needle",
        "Measuring CSF pressure ",
        "Collection of samples",
        "Withdrawing the needle",
        "Dressing the site",
        "Lying down",
        "Instructions for going home",
      ]
    }
  end

  def arterial_sampling
    {
      :title     => "Arterial Blood Gas Sampling",
      :snomed_id => 277762005,
      :steps     => []
    }
  end

  def cannular_insertion
    {
      :title     => "Central Venous Cannular Insertion",
      :snomed_id => 233527006,
      :steps     => []
    }
  end
end
