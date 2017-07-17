class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :location
      t.string :city
      t.integer :pax_num
      t.integer :price
      t.references :user

      t.timestamps
    end
  end
end
