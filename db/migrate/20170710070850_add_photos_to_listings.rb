class AddPhotosToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :photos, :string
  end
end
