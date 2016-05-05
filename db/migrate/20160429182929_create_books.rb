class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :summoner_id
      t.string :summoner_name

      t.timestamps null: false
    end
  end
end
