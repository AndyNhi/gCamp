class RemoveColumnQuoteAndAuthorFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :quote
    remove_column :pages, :author
  end
end
