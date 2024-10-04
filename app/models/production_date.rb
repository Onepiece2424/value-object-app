class ProductionDate < ApplicationRecord
  belongs_to :item
  validates :manufacture_date, presence: true
end
