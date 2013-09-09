class UsersController < ApplicationController
  
  before_filter :require_logged_in, :only => :show
  
  def new
  end
  
  def create
    user = User.new(params[:user])
    if user.save
      redirect_to user
    else
      flash[:error] = "try again"
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
end
