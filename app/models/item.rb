class Item < ApplicationRecord
  has_many :production_dates, dependent: :destroy
end
