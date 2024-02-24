class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true

  has_many :categories, foreign_key: 'user_id', dependent: :destroy
  has_many :payments, foreign_key: 'author_id', dependent: :destroy
end
