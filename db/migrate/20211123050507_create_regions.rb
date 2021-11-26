class CreateRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :regions do |t|
      t.string :title
      t.string :country
      t.string :currency
      t.decimal :tax, precision: 10, scale: 2
      t.timestamps
    end
  end
end
