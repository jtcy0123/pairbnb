class AddColumnReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :total, :decimal
    add_column :reservations, :payment_status, :string, default: "pending"
  end
end
