class Drug < ActiveRecord::Base
  has_many :patient_drugs
  has_many :patients, through: :patient_drugs
  validates :name, presence: true
  validates :description, presence: true
  validates :cost, presence: true
end
