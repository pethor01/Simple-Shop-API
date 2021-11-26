class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.references :region
      t.string :title
      t.text :description 
      t.string :image_url
      t.decimal :price, precision: 20, scale: 2
      t.string :sku
      t.integer :stock
      t.timestamps
    end
  end
end
