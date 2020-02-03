# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, foreign_key: 'creator_id', dependent: :destroy
  has_many :comments, foreign_key: 'commenter_id', dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_requests, class_name: 'Request', foreign_key: 'sender_id'
  has_many :receved_requests, class_name: 'Request', foreign_key: 'recever_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { in: 3..100 }
  validates :last_name, presence: true, length: { in: 3..100 }
  validates :user_name, presence: true, length: { in: 3..100 }
  validates :gender, presence: true

  def friends
    sent = sent_requests.map do |friendship|
      friendship.recever if friendship.status
    end
    receved = receved_requests.map do |friendship|
      friendship.sender if friendship.status
    end
    (sent + receved).compact
  end

  def not_friend
    collect = []
    other = User.all.map do |user|
      next if user == self

      if !friends.include?(user) && !pending_request.include?(user) && !friend_request.include?(user)
        collect << user
      end
    end
    collect.compact
  end

  def pending_request
    sent_requests.map { |friendship| friendship.recever unless friendship.status }.compact
  end

  def friend_request
    receved_requests.map do |friendship|
      friendship.sender unless friendship.status
    end.compact
  end

  def accept_request(user)
    Request.all.map do |x|
      if (x.friend_pair == "#{user.id},#{id}") || (x.friend_pair == "#{id},#{user.id}")
        return false
      end
    end
    friendship.friend_pair = "#{id},#{user.id}"
    friendship = receved_requests.find { |f| f.sender == user }
    friendship.status = true
    friends << friendship
    friendship.save
  end

  def send_request(user)
    Request.all.map do |x|
      if (x.friend_pair == "#{user.id},#{id}") || (x.friend_pair == "#{id},#{user.id}")
        return false
      end
    end
    friend_pair = "#{id},#{user.id}"
    Request.create(recever_id: user.id, sender_id: id, friend_pair: friend_pair)
  end

  def friend?(user)
    friends.include?(user)
  end

  def feed
    friends_ids = friends.map(&:id)
    friends_ids.join(',')
    Post.where('creator_id IN (:friends_ids) OR creator_id = :user_id',
               friends_ids: friends_ids, user_id: id).to_a
  end
end
