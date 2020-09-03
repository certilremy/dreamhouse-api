class House < ApplicationRecord
  validates :name, presence: true, length: { minimum: 8 }
  validates :description, presence: true, length: { minimum: 15 }
  validates :price, presence: true
end
