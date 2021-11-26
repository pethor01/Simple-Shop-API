class Region < ApplicationRecord
  has_many :products
  validates :title, :country, :currency,  :tax, presence: true
end
