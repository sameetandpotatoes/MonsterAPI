class RemoveBirthday < ActiveRecord::Migration
  def up
    remove_column :users, :birthday
  end
  def change
  end
end
