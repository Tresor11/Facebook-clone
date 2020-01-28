# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
    @new_post = current_user.posts.build
    @comment = current_user.comments.build
    @like = current_user.likes.build
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'Successfully posted!'
      redirect_to posts_path
    else
      flash[:alert] = 'Failed to post'
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :creator_id)
  end
end
