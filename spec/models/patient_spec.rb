require 'rails_helper'

RSpec.describe Patient, type: :model do 
  subject do 
    Patient.new({
      first_name: "first name",
      last_name: "last name",
      dob: 12.years.ago,
      description: "lfkajfdalldfkjaldfjaldjfakdfja;",
      gender: "gender",
      blood_type: "blood type",
      clinic_id: 1,
      })
  end

  let(:clinic) do 
    Clinic.new ({
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

  let(:drug) do 
    Drug.new({
      name: "name",
      description: "description",
      cost: 2.0
      })
  end

  it "should have info" do 
    expect(subject.first_name).to eq("first name")
    expect(subject.last_name).to eq("last name")
    expect(subject.dob).to eq(12.years.ago.to_date)
    expect(subject.description).to eq("lfkajfdalldfkjaldfjaldjfakdfja;")
    expect(subject.gender).to eq("gender")
    expect(subject.blood_type).to eq("blood type")
    expect(subject.clinic_id).to eq(1)
  end

  it "shouldn't not have info" do 
    expect(subject.first_name).not_to eq(nil)
    expect(subject.last_name).not_to eq(nil)
    expect(subject.dob).not_to eq(nil)
    expect(subject.description).not_to eq(nil)
    expect(subject.gender).not_to eq(nil)
    expect(subject.blood_type).not_to eq(nil)
    expect(subject.clinic_id).not_to eq(nil)
  end

  it "should validate when no first name" do
    new_patient = Patient.new
    expect(new_patient.valid?).to eq(false)
    expect(new_patient.errors).to include(:first_name)
    expect(new_patient.errors.full_messages).to include("First name can't be blank") 
  end

  it "should validate when no last name" do
    new_patient = Patient.new
    expect(new_patient.valid?).to eq(false)
    expect(new_patient.errors).to include(:last_name)
    expect(new_patient.errors.full_messages).to include("Last name can't be blank") 
  end

  it "should validate when no description" do
    new_patient = Patient.new
    expect(new_patient.valid?).to eq(false)
    expect(new_patient.errors).to include(:description)
    expect(new_patient.errors.full_messages).to include("Description can't be blank") 
  end

  it "should validate when no gender" do
    new_patient = Patient.new
    expect(new_patient.valid?).to eq(false)
    expect(new_patient.errors).to include(:gender)
    expect(new_patient.errors.full_messages).to include("Gender can't be blank") 
  end

  it "should validate when no blood type" do
    new_patient = Patient.new
    expect(new_patient.valid?).to eq(false)
    expect(new_patient.errors).to include(:blood_type)
    expect(new_patient.errors.full_messages).to include("Blood type can't be blank") 
  end

  it "should have doctors" do 
    subject.doctors << doctor
    expect(subject.doctors.length).to eq(1)
  end

  it "should have prescriptions" do 
    subject.drugs << drug
    expect(subject.drugs.length).to eq(1)
  end

  it { should belong_to(:clinic) }

  it { should have_many(:patient_drugs)}

  it { should have_many(:drugs)}

  it "should be able to transfer from waiting room" do 
    subject.save
    subject.wait!
    expect(subject.current_state.events.keys).to eq([
        :wait,
        :check,
        :examine,
        :operate,
        :leave
      ])
  end

  it "should be able to transfer from xray" do 
    subject.save
    subject.examine!
    expect(subject.current_state.events.keys).to eq([
      :check,
      :operate,
      :pay
    ])
  end

  it "should transfer from doctor" do 
    subject.save
    subject.check!
    expect(subject.current_state.events.keys).to eq([
      :examine,
      :operate,
      :pay
    ])
  end

  it "should transfer from surgery" do 
    subject.save
    subject.operate!
    expect(subject.current_state.events.keys).to eq([
      :check,
      :pay,
      :examine
    ])
  end

  it "should transfer from paying" do 
    subject.save
    subject.operate!
    subject.pay!
    expect(subject.current_state.events.keys).to eq([
      :leave
    ])
  end

  it "should transfer from leaving" do 
    subject.save
    subject.operate!
    subject.pay!
    subject.leave!
    expect(subject.current_state.events.keys).to eq([
      ])
  end

end







