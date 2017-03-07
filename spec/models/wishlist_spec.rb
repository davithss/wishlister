require 'rails_helper'

RSpec.describe Wishlist, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:wishlist_items) }
  it { is_expected.to accept_nested_attributes_for(:wishlist_items) }
end
