require 'ap'

module Fixtures
  extend self

  def seed
    Proc.new { |hash|
      begin
        steps = hash.delete(:steps)
        procedure = Procedure.create(hash)
        steps.each do |step|
          Step.create(
            step.merge(:procedure_id => procedure.id)
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
      :consent => "Headache
Abnormal sensation in the leg
Spinal and epidural bleeding",
      :materials => "* Medicinal Products
* Iodine
* Dressing pack
* Gloves
* Spinal needles
* Dry dressing
* Menometer
* Universal containers",
      :precautions => "* Thrombocytopenia (platelet count less than 50,000)			 		
* Evidence of increased intracranial pressure: Increased blood pressure with widened pulse pressure, papilledema, or significant decrease in the level of consciousness until imaging studies have ruled out mass effect.			
* New focal neurological findings and/or lesions, or imaging studies revealing significant mass effect.				 					
* Patients with coagulation defects or those receiving anticoagulant therapy.	
* Cutaneous infection at the site of procedure.				 	
* Use caution with patients with a history of low back pain, lower extremity neuralgia or sciatica.		 					
* Patients with prior back surgery will be evaluated by the Neurosurgical Service prior to the procedure and may require they complete the procedure",
      :steps     => [
        {
          :title => "Preparing the materials",
          :to_do => "",
          :to_say => ""
        },
        {
          :title  => "Positioning the patient",
          :to_do  => "This is the most important step. The lateral decubitus position may be used; firm bed, head on pillow, head flexed with chin on the chest, legs maximally flexed toward the head. Alternatively, the patient may be sitting, flexed forward and supported by stable table or assistant.",
          :to_say => "We just need to get you in the correct position for this procedure. This is very important. The idea is to make the space between the bone in your back as wide as possible. We are going to do this lying on your side. Bring your knees up as far as it can go and your chin towards your chest. Perfect."
        },
        {
          :title  => "Identifying the area for procedure",
          :to_do  => "Identify interspaces and mark puncture site at the L4-5 interspaces in a perpendicular line from the iliac crest. The L3-4 interspace above this level may also be used. ",
          :to_say => "I'm going to press around your back. This may be slightly uncomfortable. I'm going to be making a mark on your skin so that we know where we are going. I'm going to be using the back of this needle."
        },
        {
          :title => "Cleaning",
          :to_do => "Using sponge applicator provided in LP tray, prepare the back with povidone iodine solution beginning at the site marked for the needle puncture, working outward; repeat twice.	Drape the patient.",
          :to_say => "I'm going to clean your skin now. It can be a bit cold. I'm then going to place this drape over you to keep the area clean."
         },
         {
           :title => "Local Anaesthetic",
           :to_do => "Infiltrate the skin and subcutaneous tissue with preservative free 1% lidocaine with a 22-25-gauge needle. Leave for 60 secs. Check the skin to ensure that it is numb.",
           :to_say => "I'm going to give your local anaesthetic now. It is now going to be a sharp scratch followed by a bruning"
        },
        {
          :title => "Introducing the needle",
          :to_do => "Insert the spinal needle into the midline of the interspace with bevel up. Direct the needle on a 10-degree angle toward the umbilicus (horizontal axis). Needle should always enter with the bevel in the sagittal plane and be rotated to the axial plane, regardless of patient position.

Once CSF flow is established, rotate the needle 90 degrees counter-clock wise (bevel in transverse plane) for patients in the lateral decubitus position. If the patient is in the sitting position no adjustment is needed.
          
## Complications

If the patient complains of nerve root pain, do not advance the needle. Withdraw 2 millimeters, remove stylet and check for CSF. If none, then replace the stylet and remove. Remove the needle to subcutaneous tissue, change angle and continue. If repeated bony resistance is noted, discard the needle and replace it. If blood is returned, watch for clearing of fluid; if no clearing, replace the stylet, remove the needle and notify the attending MD.

### Terminate treatment if:

* Severe pain which persists
* Failure to access the CSF space after three attempts",
          :to_say => "I'm not already in the spinal space. We will be finished very soon. You are doing very well."
        },
        {
          :title => "Measuring CSF pressure ",
          :to_do => "You can only do this if the procedure is being performed in the lateral decubitus position.
Attached the manometer to the end of the needle. Ensure that the 3 way tap is directed upwards towards manometer. Take note of the reading once the fluid level no longer goes higher.",
          :to_say => "Just measuring the pressure at the moment. You shouldn't be feeling anything. We are half way there."
        },
        {
          :title => "Collection of samples",
          :to_do => "Allow the CSF to drip",
          :to_say => "We are just collecting the samples now that we are going to send to the lab. We will be finished after this."
        },
        {
          :title => "Withdrawing the needle",
          :to_do => "For patients in the lateral decubitus position, replace stylet, turn needle 90- degrees clockwise (sagittal plane) and remove needle.",
          :to_say => "Just taking the needle out and we will be done."
        },
        {
          :title => "Dressing the site",
          :to_do => "Cleanse procedure area of povidone iodine solution and place dry sterile dressing.",
          :to_say => "We are just going to clean it now and put a dressing on."
        },
        {
          :title => "Lying down",
          :to_do => "Advise patient to lie prone for 30-60 minutes and to increase oral fluids over the next 12-24 hours.",
          :to_say => "It is really important how that you lie flat for up to one hour. This is to prevent the spinal fluid from leaking out. If this happens, you can get quite a severe headache. We can place a pillow under your head to support you."
        },
        {
          :title => "Instructions for going home",
          :to_do => "Instruct the patient to observe LP site for any signs of bleeding or infection",
          :to_say => "It is important that you get any headaches or pain in your back that you should let us know. This is our phone number. Keep well hydrated by drinking plenty of water."
        }
      ],
    }
  end

  def arterial_sampling
    {
      :title     => "Arterial Blood Gas Sampling",
      :snomed_id => 277762005,
      :steps     => [],
      :consent => "",
      :materials => "",
      :precautions => "",
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
