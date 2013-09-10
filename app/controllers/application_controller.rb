class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    # returns the current user
    User.find_by_session_token(session[:token])
  end
  helper_method :current_user

  
  def require_logged_in
    #check to see if theres a current user and if not redirect to sign in page
    redirect_to new_session_url unless current_user
  end
  
  def require_not_logged_in
    #check to see if theres a current user and if so redirect to the user's show page
    redirect_to current_user if current_user
  end
  
end
