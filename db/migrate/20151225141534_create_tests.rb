class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :slug, null: false
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :project_id

      t.timestamps null: false
    end
    add_index :tests, :slug
  end
end
