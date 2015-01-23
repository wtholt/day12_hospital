class AddPatientIdtoDrugs < ActiveRecord::Migration
  def change
    add_column :drugs, :patient_id, :integer
  end
end
