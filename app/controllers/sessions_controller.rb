class SessionsController < ApplicationController
  
  before_filter :require_logged_in, :only => [:destroy]
  before_filter :require_not_logged_in, :except => [:destroy]
  
  def new
    #sign in form
  end
  
  def create
    # verify credentials
    #find user based on credentials
    #log in user
    #redirect_to user page
    user = User.find_by_email(params[:user][:email])
  
    if user && user.is_password?(params[:user][:password])
      login_user!(user)
      redirect_to user
    else
      render :new
    end
  end
  
  def destroy
    logout_user!
    render :new
  end
  
  protected
  def login_user!(user)
    # give the user a new session_token and set session[:token] to the same thing
    user.reset_session_token!
    session[:token] = user.session_token
  end
  
  def logout_user!
    # change the current user's session token and change the database session token
    current_user.reset_session_token!
    session[:token] = nil
  end
end
