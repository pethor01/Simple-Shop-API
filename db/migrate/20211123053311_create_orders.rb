class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user
      t.text :shipping_address
      t.integer :order_total
      t.integer :total_price
      t.date :paid_at
      t.boolean :paid,  default: false
      t.timestamps
    end
  end
end
