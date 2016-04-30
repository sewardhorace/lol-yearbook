class AddFieldsToBook < ActiveRecord::Migration
  def change
    add_column :books, :summoner_name, :string
  end
end
