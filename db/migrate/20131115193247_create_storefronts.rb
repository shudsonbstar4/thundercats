class CreateStorefronts < ActiveRecord::Migration
  def change
    create_table :storefronts do |t|
      t.string :title
      t.integer :product_id
      t.integer :category_id

      t.timestamps
    end
  end
end
