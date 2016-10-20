class CreateTestresults < ActiveRecord::Migration
  def change
    create_table :testresults do |t|
      t.integer :heading_level
      t.string :result
      t.text :note
      t.string :environment
      t.integer :test_id
      t.integer :testcase_id

      t.timestamps null: false
    end
  end
end
