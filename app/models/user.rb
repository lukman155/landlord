class User < ApplicationRecord
  has_many :properties, foreign_key: :landlord_id

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
end
