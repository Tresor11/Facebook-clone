# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  validates :content, presence: true, length: { minimum: 5, maximum: 250 }

  default_scope -> { order(created_at: :desc) }
end
