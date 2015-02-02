class Patient < ActiveRecord::Base
  BLOOD_TYPES = [
    ["A+", "A+"],
    ["A-", "A-"],
    ["B+", "B+"],
    ["B-", "B-"],
    ["AB+", "AB+"],
    ["AB-", "AB-"],
    ["O+", "O+"], 
    ["O-", "O-"]
  ]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :description, presence: true
  validates :gender, presence: true
  validates :blood_type, presence: true
  validate :invalid

  belongs_to :clinic
  has_many :patient_drugs
  has_many :drugs, through: :patient_drugs
  has_many :doctors, as: :doctorable

  def invalid
    if self.dob
      errors.add(:dob, 'is invalid. You must have been born more than 10 years ago.') if self.dob > 10.years.ago.to_date
    end
  end

  include Workflow
  workflow do
    state :waiting_room do
      event :wait, transitions_to: :waiting_room
      event :check, transitions_to: :doctor
      event :examine, transitions_to: :xray
      event :operate, transitions_to: :surgery
      event :leave, transitions_to: :leaving
    end
    state :doctor do
      event :examine, transitions_to: :xray
      event :operate, transitions_to: :surgery
      event :pay, transitions_to: :paying
    end
    state :xray do
      event :check, transitions_to: :doctor
      event :operate, transitions_to: :surgery
      event :pay, transitions_to: :paying
    end
    state :surgery do
      event :check, transitions_to: :doctor
      event :pay, transitions_to: :paying
    end
    state :paying do
      event :leave, transitions_to: :leaving
    end
    state :leaving
  end
end
