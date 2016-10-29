class Sensor < ApplicationRecord
  has_many :labels

  validates :title, presence: true,
            length: {minimum: 3}
end
