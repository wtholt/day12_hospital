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

  let!(:patient) { FactoryGirl.create(:patient) }

  it 'should return patient default state' do 
    expect(helper.patient_workflow(subject)).to eq("waiting_room")
  end

  it 'should return patient starting state' do 
    expect(helper.workflow_state_helper_method(subject)).to eq("Patient is in the waiting room")
  end

  it 'should return that patient is with doctor' do 
    patient.check!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is with the Doctor")
  end

  it 'should return that the patient is in xray' do 
    patient.examine!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is in the examination room")
  end

  it 'should return that the patient is in surgery' do 
    patient.operate!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is in surgery")
  end

  it 'should return that the patient is paying' do 
    patient.operate!
    patient.pay!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is paying")
  end

  it 'should return that the patient is leaving' do 
    patient.operate!
    patient.pay!
    patient.leave!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is being discharged")
  end

  it 'should return that the patient is in the waiting room' do 
    patient.wait!
    expect(helper.workflow_state_helper_method(patient)).to eq("Patient is in the waiting room")
  end






end