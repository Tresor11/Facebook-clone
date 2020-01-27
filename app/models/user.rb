# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, foreign_key: 'creator_id', dependent: :destroy
  has_many :comments, foreign_key: 'commenter_id',dependent: :destroy
  has_many :likes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { in: 3..100 }
  validates :last_name, presence: true, length: { in: 3..100 }
  validates :user_name, presence: true, length: { in: 3..100 }
  validates :gender, presence: true
end
