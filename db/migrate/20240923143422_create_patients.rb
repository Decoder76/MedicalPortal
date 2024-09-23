class CreatePatients < ActiveRecord::Migration[7.2]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
