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

end
