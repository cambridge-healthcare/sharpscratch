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
      arterial_blood_gas_sampling,
      central_venous_catheterisation
    ]
  end

  def lumbar_puncture
    {
      :title => "Lumbar Puncture",
      :steps => [
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

  def arterial_blood_gas_sampling
    {
      :title => "Arterial Blood Gas Sampling",
      :steps => []
    }
  end

  def central_venous_catheterisation
    {
      :title => "Central Venous Catheterisation",
      :steps => []
    }
  end
end
