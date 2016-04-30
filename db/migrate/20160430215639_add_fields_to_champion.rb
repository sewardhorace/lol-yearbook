class AddFieldsToChampion < ActiveRecord::Migration
  def change
    add_column :champions, :name, :string
    add_column :champions, :title, :string
    add_column :champions, :img_url, :string
    add_column :champions, :highest_grade, :string
    add_column :champions, :mastery_points, :int
    add_column :champions, :mastery_level, :int
  end
end
