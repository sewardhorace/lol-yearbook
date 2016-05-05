class CreateStaticChampions < ActiveRecord::Migration
  def change
    create_table :static_champions do |t|
      t.integer :champion_id, index: true #champion id from riot api
      t.string :name
      t.string :title
      t.string :profile_url
      t.string :splash_url

      t.timestamps null: false
    end
  end
end
