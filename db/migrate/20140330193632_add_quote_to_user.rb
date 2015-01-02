class AddQuoteToUser < ActiveRecord::Migration
  def change
    add_column :users, :quote, :string
  end
end
