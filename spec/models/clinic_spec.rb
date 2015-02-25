require 'rails_helper'

RSpec.describe Clinic, type: :model do
  subject do 
    Clinic.new({
      name: "Clinic",
      address: "144 Heritage Circle",
      city: "City",
      state: "SC",
      zip: 29464

      })
  end

  let(:doctor) do 
    Doctor.new({
      name: "name"
      })
  end

  let(:patient) do 
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

  let(:drug) do 
    Drug.new({
      name: "name",
      description: "description description description",
      cost: 2.0,
      patient_id: 1,
      })
  end

  it "should have info" do
    expect(subject.name).to eq("Clinic")
    expect(subject.address).to eq("144 Heritage Circle")
    expect(subject.city).to eq("City")
    expect(subject.state).to eq("SC")
    expect(subject.zip).to eq(29464)
  end

  it "should have a name" do 
    expect(subject.name).to eq("Clinic")
  end

  it "should not have a name" do 
    expect(subject.name).to_not eq(nil)
  end

  it 'should have an address' do
    expect(subject.address).to eq('144 Heritage Circle')
  end

  it 'should not have an address' do 
    expect(subject.address).not_to eq(nil)
  end

  it 'should have a city' do
    expect(subject.city).to eq('City')
  end

  it 'shouldnt not have a city' do 
    expect(subject.city).not_to eq(nil)
  end

  it 'should have a state' do
    expect(subject.state).to eq('SC') 
  end

  it 'should not have a state' do 
    expect(subject.state).to_not eq(nil)
  end

  it 'should have a zip' do 
    expect(subject.zip).to eq(29464)
  end

  it 'should not have a zip' do 
    expect(subject.zip).to_not eq(nil)
  end

  it "should have info" do
    expect(subject.name).not_to eq(nil)
    expect(subject.address).not_to eq(nil)
    expect(subject.city).not_to eq(nil)
    expect(subject.state).not_to eq(nil)
    expect(subject.zip).not_to eq(nil)
  end

  it "should validate when no name" do 
    new_clinic = Clinic.new
    expect(new_clinic.valid?).to eq(false)
    expect(new_clinic.errors).to include(:name)
    expect(new_clinic.errors.full_messages).to include("Name can't be blank")
  end

  it "should validate when no address" do 
    new_clinic = Clinic.new
    expect(new_clinic.valid?).to eq(false)
    expect(new_clinic.errors).to include(:address)
    expect(new_clinic.errors.full_messages).to include("Address can't be blank")
  end

  it "should validate when no city" do
    new_clinic = Clinic.new
    expect(new_clinic.valid?).to eq(false)
    expect(new_clinic.errors).to include(:city)
    expect(new_clinic.errors.full_messages).to include("City can't be blank") 
  end

  it "should validate when no state" do 
    new_clinic = Clinic.new
    expect(new_clinic.valid?).to eq(false)
    expect(new_clinic.errors).to include(:state)
    expect(new_clinic.errors.full_messages).to include("State can't be blank")
  end

  it "should validate when no zip" do
    new_clinic = Clinic.new
    expect(new_clinic.valid?).to eq(false)
    expect(new_clinic.errors).to include(:zip)
    expect(new_clinic.errors.full_messages).to include("Zip can't be blank") 
  end

  it "should validate when we create" do 
    new_clinic = Clinic.new
    expect(new_clinic.errors).not_to include(:name, :address, :city, :state, :zip)
    new_clinic.save
    expect(new_clinic.errors).to include(:name, :address, :city, :state, :zip)
    expect(new_clinic.errors.full_messages).to include("Name can't be blank", 
      "Address can't be blank",
      "City can't be blank",
      "State can't be blank",
      "Zip can't be blank",)
  end

  it "should have doctors" do
    subject.doctors << doctor
    expect(subject.doctors.length).to eq(1)
  end

  it "should have patients" do
    subject.patients << patient
    expect(subject.patients.length).to eq(1) 
  end

  it "should have prescriptions" do
    subject.drugs << drug
    expect(subject.drugs.length).to eq(1)
  end

  it {should have_many(:patients)}


end