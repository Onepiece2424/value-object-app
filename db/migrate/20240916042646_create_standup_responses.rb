class CreateStandupResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :standup_responses do |t|
      t.string :user
      t.text :response

      t.timestamps
    end
  end
end
