class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :flag
      t.integer :user_id, index: true
      t.integer :comment_id, index: true

      t.timestamps null: false
    end
  end
end
