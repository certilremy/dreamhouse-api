class User < ApplicationRecord
  before_save { self.username = username.downcase }
  validates :username, presence: true, length: { minimum: 4 },
                       uniqueness: true
  has_many :houses, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
