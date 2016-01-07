class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :timezone, :string
  end
end
