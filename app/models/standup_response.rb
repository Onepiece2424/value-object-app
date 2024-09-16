class StandupResponse < ApplicationRecord
  validates :user, presence: true
  validates :response, presence: true
end
