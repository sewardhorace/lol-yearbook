class AddRegionToBook < ActiveRecord::Migration
  def change
    add_column :books, :region, :string
  end
end
