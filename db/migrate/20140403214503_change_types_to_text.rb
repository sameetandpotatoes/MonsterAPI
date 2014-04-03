class ChangeTypesToText < ActiveRecord::Migration
  def change
    change_column :users, :users, :text
    change_column :users, :provider, :text
    change_column :users, :string, :text
    change_column :users, :uid, :text
    change_column :users, :name, :text
    change_column :users, :oauth_token, :text
    change_column :users, :oauth_expires_at, :text
    change_column :users, :created_at, :text
    change_column :users, :updated_at, :text
    change_column :users, :quote, :text
    change_column :users, :location, :text
    change_column :users, :image, :text
  end
end
