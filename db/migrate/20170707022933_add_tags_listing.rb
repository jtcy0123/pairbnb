class AddTagsListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :tag_list, :string, array: true, default: []
  end
end
