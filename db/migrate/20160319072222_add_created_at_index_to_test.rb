class AddCreatedAtIndexToTest < ActiveRecord::Migration
  def change
    add_index :tests, :created_at
    add_index :tests, :updated_at
  end
end
