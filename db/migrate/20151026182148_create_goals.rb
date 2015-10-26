class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :body, null: false
      t.integer :user_id,  null: false
      t.boolean :private, null: false, default: false

      t.timestamps
    end
    add_index :goals, :user_id
  end
end
