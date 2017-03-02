class WishlistItem < ApplicationRecord
  belongs_to :wishlist, optional: true
  validates :wishlist, presence: true
end
