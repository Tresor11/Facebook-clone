# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: 'creator_id'
  # validates :first_name, presence: true, length: { minimum: 3 }
  # validates :last_name, presence: true, length: { minimum: 3 }
  # validates :user_name, presence: true, length: { minimum: 3 }
  # validates :gender, presence: true
end
