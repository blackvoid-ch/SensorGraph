class Result < ApplicationRecord
  belongs_to :label

  validates :value, presence: true, numericality: true
end
