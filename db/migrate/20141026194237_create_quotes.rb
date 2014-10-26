class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :quote_line
      t.string :author

      t.timestamps
    end
  end
end
