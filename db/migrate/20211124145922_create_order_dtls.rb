class CreateOrderDtls < ActiveRecord::Migration[6.1]
  def change
    create_table :order_dtls do |t|
      t.references :order
      t.references :product
      t.decimal :total_price
      t.integer :total_order
      t.timestamps
    end
  end
end
