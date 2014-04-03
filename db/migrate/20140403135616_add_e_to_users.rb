class AddEToUsers < ActiveRecord::Migration
  def change
    add_column :users, :e, :string
  end
end
