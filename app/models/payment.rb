class Payment < ApplicationRecord
  belongs_to :order
  enum status: %i[unpaid paid]
end
