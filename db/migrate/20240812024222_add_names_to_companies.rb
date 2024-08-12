class AddNamesToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :first_name, :string
    add_column :companies, :last_name, :string
  end
end
