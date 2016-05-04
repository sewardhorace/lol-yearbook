class UpdateStaticChampionImages < ActiveRecord::Migration
  def change
    remove_column :static_champions, :img_url, :string
    add_column :static_champions, :profile_url, :string
    add_column :static_champions, :splash_url, :string
  end
end
