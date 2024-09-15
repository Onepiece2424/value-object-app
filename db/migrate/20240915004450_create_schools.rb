class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :email
      t.integer :established_year

      t.timestamps
    end
  end
end
