class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User"
  belongs_to :post
  validates :comment_content, presence: true, length: { minimum: 2, maximum: 250 }
  default_scope -> { order(created_at: :desc) }
end
