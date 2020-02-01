# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation first_name last_name gender user_name])
  end

  def after_sign_in_path_for(_resource)
    posts_url
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

  def pendeing_request
    sent_requests.map { |friendship| friendship.recever unless friendship.status }.compact
  end

  def friend_request
    receved_requests.map do |friendship|
      friendship.sender unless friendship.status
    end .compact
  end

  def accept_request(user)
    friendship = receved_requests.find { |f| f.sender == user }
    friendship.status = true
    friends << friendship
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
