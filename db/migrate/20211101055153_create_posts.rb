class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :category_id, null: false
      t.string :image_id, null: false
      t.string :item_name, null: false
      t.text :review, null: false
      t.string :country, null: false
      t.string :place, null: false
      t.string :price, null: false
      t.float :rate, null: false

      t.timestamps
    end
  end
end
