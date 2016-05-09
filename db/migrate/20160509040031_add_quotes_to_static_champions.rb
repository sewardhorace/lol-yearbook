class AddQuotesToStaticChampions < ActiveRecord::Migration
  def change
    add_column :static_champions, :quote, :string
  end
end
