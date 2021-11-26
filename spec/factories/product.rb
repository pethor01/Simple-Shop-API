require 'rails_helper'

# created model
FactoryBot.define do
  factory :product do
    title {'PH Tshirt'}
    description { 'Pilipinas  T shirt'}
    image_url { 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/e18dd982-179c-4e8b-8057-2b5736226086/philippines-dri-fit-basketball-t-shirt-ttrxhH.png'}
    sku {Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 5, min_numeric: 3).upcase}
    stock { 10 }
    price { 1500}
    region { }
  end

end