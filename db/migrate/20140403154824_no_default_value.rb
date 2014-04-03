class NoDefaultValue < ActiveRecord::Migration
  def change
    change_column :users, :github_results, :text
    change_column :users, :linkedin_results, :text
  end
end
