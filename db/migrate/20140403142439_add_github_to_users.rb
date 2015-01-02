class AddGithubToUsers < ActiveRecord::Migration
  def change
    drop_table :users
    create_table :users do |t|
      t.string   :users, :provider, :string
      t.string   :users, :uid, :string
      t.string   :users, :name, :string
      t.string   :users, :oauth_token, :string
      t.datetime :users, :oauth_expires_at, :string
      t.datetime :users, :created_at, :string
      t.datetime :users, :updated_at, :string
      t.string   :users, :quote, :string
      t.string   :users, :location, :string
      t.string   :users, :email, :string
      t.string   :users, :image, :string
      t.string   :users, :e, :string
      t.string   :github_results, array: true, default: []
      t.timestamps
    end
  end
end
