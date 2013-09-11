class PasswordResetsController < ApplicationController
  
  def new
      
  end
  
  def create
    # see if there is a user associated w/ email
    user = User.find_by_email(params[:email])
    
    user.send_password_reset if user 
    
    # redirect to sign in page with message "email was sent"
    redirect_to new_session_url, :notice => "Password reset email sent"
  end
  
  def edit
    @password_reset_token = params[:id]
  end
  
  def update
    user = User.find_by_password_reset_token!(params[:id])
    redirect_to new_password_reset_url if user.nil?
    if !passwords_match?(params[:password], params[:passwordconfirm])
      flash[:error] = "passwords don't match"
      redirect_to edit_password_reset_url
    elsif !token_not_expired(user)
      flash[:error] = "time limit has expired"
      redirect_to new_password_reset_url
    elsif user.update_attributes(:password => params[:password])
      user.password_reset_token = user.class.generate_token
      redirect_to new_session_url
      user.save!
    else
      redirect_to edit_password_reset_url
    end
  end
  
  private
  def passwords_match?(password, password_confirmation)
    password == password_confirmation
  end
  
  def token_not_expired(user)
    user.password_reset_sent_at > 1.hours.ago
  end
  
end
