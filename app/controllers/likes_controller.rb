class LikesController < ApplicationController
  def created
    @like=current_user.likes.build(like_params)
  end

  private
  
  def like_params
    params.require(:like).permit(:user_id,:post_id)
  end
end
