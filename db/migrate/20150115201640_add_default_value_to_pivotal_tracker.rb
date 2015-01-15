class AddDefaultValueToPivotalTracker < ActiveRecord::Migration
  def change
      change_column :users, :pivotal_tracker_token, :string, default: ''
  end
end
