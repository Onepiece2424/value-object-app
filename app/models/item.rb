class Item < ApplicationRecord
  has_many :production_dates, dependent: :destroy
  accepts_nested_attributes_for :production_dates, allow_destroy: true
end
