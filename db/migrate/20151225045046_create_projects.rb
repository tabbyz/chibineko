class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.integer :user_id
      t.integer :team_id

      t.timestamps null: false
    end
    add_index :projects, :name
    add_index :projects, [:name, :team_id], unique: true
  end
end
