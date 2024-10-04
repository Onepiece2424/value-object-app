class Item < ApplicationRecord
  has_many :production_dates, inverse_of: :item, dependent: :destroy
  accepts_nested_attributes_for :production_dates, allow_destroy: true
end
