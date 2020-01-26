# frozen_string_literal: true

module UsersHelper
  def my_posts
    current_user.posts.all
  end
end
