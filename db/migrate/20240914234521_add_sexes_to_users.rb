class AddSexesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :sex, :integer
  end
end
