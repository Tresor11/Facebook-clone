# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(like_params)
    if @like.save
      redirect_to post_path(@like.post)
    else
      redirect_to posts_path
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
