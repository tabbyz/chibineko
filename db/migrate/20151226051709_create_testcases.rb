class CreateTestcases < ActiveRecord::Migration
  def change
    create_table :testcases do |t|
      t.integer :case_id
      t.integer :heading_level
      t.text :body
      t.string :result
      t.text :note
      t.integer :test_id

      t.timestamps null: false
    end
  end
end
