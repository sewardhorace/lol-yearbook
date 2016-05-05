class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.integer :champion_id #champion id from riot api
      t.integer :book_id, index: true
      t.boolean :chest_earned
      t.string :highest_grade
      t.integer :mastery_points
      t.integer :mastery_level

      t.timestamps null: false
    end
  end
end
