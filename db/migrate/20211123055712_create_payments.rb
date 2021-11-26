class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :order
      t.integer :status
      t.timestamps
    end
  end
end
