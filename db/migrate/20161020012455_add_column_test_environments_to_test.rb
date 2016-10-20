class AddColumnTestEnvironmentsToTest < ActiveRecord::Migration
  def change
    add_column :tests, :test_environments, :text
  end
end
