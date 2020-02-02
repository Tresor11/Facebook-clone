# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recever, class_name: 'User'
  validates :sender_id, presence: true
  validates :recever_id, presence: true
end
