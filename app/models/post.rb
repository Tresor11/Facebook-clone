# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :content, presence: true, length: { minimum: 5, maximum: 250 }
  default_scope -> { order(created_at: :desc) }
end
