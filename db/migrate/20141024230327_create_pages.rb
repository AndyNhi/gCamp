class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :quote
      t.string :author

      t.timestamps
    end
  end
end
