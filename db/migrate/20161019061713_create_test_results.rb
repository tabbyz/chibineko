class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
      t.string :result
      t.string :note

      t.timestamps null: false
    end
  end
end
