class Wishlist < ApplicationRecord
  has_many :wishlist_items, dependent: :destroy
  accepts_nested_attributes_for :wishlist_items, allow_destroy: true

  validates :name, uniqueness: true
  validates :name, presence: true
end
