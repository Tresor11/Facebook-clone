# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @others = current_user.not_friend
  end

  def show
    @my_posts = current_user.posts.all
  end

  def notification; end
end
