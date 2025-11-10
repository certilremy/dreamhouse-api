class User < ApplicationRecord
  # Callbacks
  before_save { self.username = username.downcase }

  # Validations
  validates :username, presence: true, length: { minimum: 4 },
                       uniqueness: true

  # Associations
  has_many :houses, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
