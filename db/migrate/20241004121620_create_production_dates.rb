class CreateProductionDates < ActiveRecord::Migration[6.1]
  def change
    create_table :production_dates do |t|
      t.date :manufacture_date
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
