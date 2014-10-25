class AddCompleteCheckboxToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :complete, :boolean, null: false, default: false
  end
end
