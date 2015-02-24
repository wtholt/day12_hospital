require 'rails_helper'

RSpec.describe PatientsHelper, type: :helper do 
  subject do 
    Patient.new({
      first_name: "first name",
      last_name: "last name",
      dob: 1990-01-27,
      description: "lfkajfdalldfkjaldfjaldjfakdfja;",
      gender: "gender",
      blood_type: "blood type",
      clinic_id: 1,
      })
  end

  it 'should return patient default state' do 
    expect(helper.patient_workflow(subject)).to eq("waiting_room")
  end

  it 'should return patient starting state' do 
    expect(helper.workflow_state_helper_method(subject)).to eq("Patient is in the waiting room")
  end




end