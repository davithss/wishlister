require 'rails_helper'

RSpec.describe WishlistItem, type: :model do
  it { is_expected.to validate_presence_of(:wishlist) }
  it { is_expected.to belong_to(:wishlist) }
end
