class ApplicationController < ActionController::Base
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      # @current_userがnilかfalseならログインユーザーを代入
      @current_user ||= User.find(session[:user_id])
    end
  end

  helper_method :current_user
end
