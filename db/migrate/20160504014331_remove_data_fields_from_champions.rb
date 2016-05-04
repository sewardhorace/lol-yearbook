class RemoveDataFieldsFromChampions < ActiveRecord::Migration
  def change
    remove_column :champions, :name, :string
    remove_column :champions, :title, :string
    remove_column :champions, :img_url, :string
  end
end
