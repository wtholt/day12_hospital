class CreatePatientDrugs < ActiveRecord::Migration
  def change
    create_table :patient_drugs do |t|
      t.integer :patient_id
      t.integer :drug_id
      t.timestamps null: false
    end
  end
end
