require 'rails_helper'

# created model
FactoryBot.define do
  factory :user do
    first_name {Faker::Name.unique.first_name }
    last_name {Faker::Name.unique.last_name }
    email { Faker::Internet.free_email }
    password { Faker::Alphanumeric.alphanumeric(number: 12, min_alpha: 3, min_numeric: 4).upcase.to_s }
    role { 0 }
  end

end
