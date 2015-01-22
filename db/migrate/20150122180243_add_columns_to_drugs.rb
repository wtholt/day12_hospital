class AddColumnsToDrugs < ActiveRecord::Migration
  def change
    add_column :drugs, :name, :string
    add_column :drugs, :description, :text
    add_column :drugs, :cost, :float
  end
end
