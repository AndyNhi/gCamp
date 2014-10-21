class RemoveTitleDescriptionFromTasks < ActiveRecord::Migration
  def down
    remove_column :tasks, :title
  end
end
