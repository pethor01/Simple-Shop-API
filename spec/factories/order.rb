require 'rails_helper'

# created model
FactoryBot.define do
  factory :order do
    product { }
    user { }
    shipping_address { 'Pilipinas  T shirt'}
    
  end

end