# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to @comment.post
    else
      redirect_to posts_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)
  end
end
