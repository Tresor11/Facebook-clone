# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
    @new_post = current_user.posts.build
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
      redirect_to @post
    else
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
