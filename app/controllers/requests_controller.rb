# frozen_string_literal: true

class RequestsController < ApplicationController
  def create
    user = User.find(params.dig(:request, :user_id))
    if current_user.friend_request.include?(user)
      current_user.accept_request(user)
      redirect_to current_user
    else
      current_user.send_request(user)
      redirect_to users_path
    end
  end

  def destroy
    user = User.find(params.dig(:request, :user_id))
    current_user.friends.delete(user) if current_user.friends.include?(user)
    if current_user.pending_request.include?(user)
      current_user.pending_request.delete(user)
    end
    if current_user.friend_request.include?(user)
      current_user.friend_request.delete(user)
    end
  end
end
