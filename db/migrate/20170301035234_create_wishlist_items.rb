class CreateWishlistItems < ActiveRecord::Migration[5.0]
  def change
    create_table :wishlist_items do |t|
      t.integer :wishlist_id
      t.string :name
      t.string :photo_url
      t.string :address

      t.timestamps
    end
  end
end
