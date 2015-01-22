class AddToClinic < ActiveRecord::Migration
  def change
    add_column :clinics, :name, :string
    add_column :clinics, :address, :string
    add_column :clinics, :city, :string
    add_column :clinics, :state, :string
    add_column :clinics, :zip, :integer
  end
end
