class AddEToUser < ActiveRecord::Migration
  def up
    add_column :users, :e, :string
  end
  def down
    remove_column :users, :birthday, :string
  end
  def change
  end
end
