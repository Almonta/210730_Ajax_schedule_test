class Blog < ApplicationRecord
  has_many :schedules, dependent: :destroy
end
