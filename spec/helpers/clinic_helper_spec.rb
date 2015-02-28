require 'rails_helper'

RSpec.describe ClinicsHelper, type: :helper do 
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

  let!(:patient) { FactoryGirl.create(:patient) }

  it 'should return default work state' do 
    expect(helper.workflow_state_helper_method(subject)).to eq("Patient is in the waiting room")
  end

  it 'shouldnt return a nil state' do 
    expect(helper.workflow_state_helper_method(subject)).not_to eq(nil)
  end

  it 'should return that the patient is with doctor' do 
    patient.check!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is with the Doctor")
    expect(helper.workflow_state_helper_method(patient)).not_to eq(nil)
  end

  it 'should return that the patient is in xray' do 
    patient.examine!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is in the examination room")
  end

  it 'shouldnt return a nil state' do 
    patient.examine!
    expect(helper.workflow_state_helper_method(patient)).not_to eq(nil)
  end

  it 'should return that the patient is in surgery' do 
    patient.operate!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is in surgery")
  end

  it 'shouldnt return a nil state' do 
    patient.operate!
    expect(helper.workflow_state_helper_method(patient)).not_to eq(nil)
  end

  it 'should return that the patient is paying' do 
    patient.examine!
    patient.pay!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is paying")
  end

  it 'shouldnt return a nil state' do 
    patient.examine!
    patient.pay!
    expect(helper.workflow_state_helper_method(patient)).not_to eq(nil)
  end

  it 'should return that the patient is leaving' do 
    patient.examine!
    patient.pay!
    patient.leave!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is being discharged")
  end

  it 'shouldnt return that the patient is leaving nil' do 
    patient.examine!
    patient.pay!
    patient.leave!
    expect(helper.workflow_state_helper_method(patient)).not_to eq(nil)
  end

  it 'should return that the patient is in the waiting room' do 
    patient.wait!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is in the waiting room")
  end

  it 'shouldnt return nil' do 
    patient.wait!
    expect(helper.workflow_state_helper_method(patient)).not_to eq(nil)
  end

end