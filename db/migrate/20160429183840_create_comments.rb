class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.string :type
      t.integer :book_id, index: true
      t.integer :champion_id, index: true
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
