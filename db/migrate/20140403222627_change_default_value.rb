class ChangeDefaultValue < ActiveRecord::Migration
  def change
    change_column :users, :github_results, :text, default: ''
    change_column :users, :linkedin_results, :text, default: ''
  end
end
