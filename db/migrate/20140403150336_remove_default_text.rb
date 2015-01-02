class RemoveDefaultText < ActiveRecord::Migration
  def change
    change_column :users, :github_results, :text, default: nil
    change_column :users, :linkedin_results, :text, default: nil
  end
end
