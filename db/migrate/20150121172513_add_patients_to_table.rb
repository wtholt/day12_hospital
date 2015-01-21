class AddPatientsToTable < ActiveRecord::Migration
  def change
    add_column :patients, :first_name, :string
    add_column :patients, :last_name, :string
    add_column :patients, :dob, :date
    add_column :patients, :description, :text
    add_column :patients, :gender, :string
    add_column :patients, :blood_type, :string
  end
end
