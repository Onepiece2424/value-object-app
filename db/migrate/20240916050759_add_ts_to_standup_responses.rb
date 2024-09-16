class AddTsToStandupResponses < ActiveRecord::Migration[6.1]
  def change
    add_column :standup_responses, :ts, :string
  end
end
