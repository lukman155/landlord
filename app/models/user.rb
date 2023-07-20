class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :properties, foreign_key: :landlord_id

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
end
