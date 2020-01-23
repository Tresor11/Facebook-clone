# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # def after_sign_in_path_for(user)
  #   user_url(user)
  # end
end
