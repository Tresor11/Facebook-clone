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
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  validates :first_name, presence: true, length: { in: 3..100 }
  validates :last_name, presence: true, length: { in: 3..100 }
  validates :user_name, presence: true, length: { in: 3..100 }
  validates :gender, presence: true

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
        user.first_name = data['name'] if user.first_name.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name # assuming the user model has a name
      #     user.image = auth.info.image assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

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
