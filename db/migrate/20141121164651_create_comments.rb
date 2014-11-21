class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :task
      t.belongs_to :user
      t.text :copy
      t.timestamps
    end
  end
end
