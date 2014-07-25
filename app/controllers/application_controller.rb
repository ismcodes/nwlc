class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
#ask about what this does?
# before_filter :allow_cross_domain_access
# def allow_cross_domain_access
# @response.headers["Access-Control-Allow-Origin"] = "*"
# end

end