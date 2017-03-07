FactoryGirl.define do
  factory :wishlist_item do
    name Faker::Name.name
    address Faker::Address.street_address
    photo_url "http://photo.com"
    wishlist
  end
end
