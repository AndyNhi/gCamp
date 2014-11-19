class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.string :role
      t.timestamp
    end
  end
end
