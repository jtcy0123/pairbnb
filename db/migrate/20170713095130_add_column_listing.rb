class AddColumnListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :city, :string
  end
end
