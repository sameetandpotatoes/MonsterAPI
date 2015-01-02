class RemoveUnnecessaryAttributesToUser < ActiveRecord::Migration
  def change
    remove_column :users, :users
    remove_column :users, :provider
    remove_column :users, :string
    remove_column :users, :uid
    remove_column :users, :name
    remove_column :users, :quote
    remove_column :users, :location
    remove_column :users, :email
    remove_column :users, :image
  end
end
