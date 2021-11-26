require 'rails_helper'

# created model
FactoryBot.define do
  factory :region do
    title {'NCR'}
    country {'Philippines' }
    currency { 'PHP'}
    tax { 0.12}
  end
end
