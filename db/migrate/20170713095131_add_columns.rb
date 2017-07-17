class AddColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :status, default: "unverified"
  end
end
