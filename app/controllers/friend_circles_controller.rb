class FriendCirclesController < ApplicationController
  
  def new
    @users = User.all
  end
  
  def create
    
    # session (and therefore current_user (method in application_controller)) both evaluate to nil at this point, although they were fine and populated one step back when the new.html.erb form was rendered.
    
    begin
      ActiveRecord::Base.transaction do 
        friend_circle = FriendCircle.new(:name => params[:friend_circle][:name], :creator_id => current_user.id)
        friend_circle_memberships = params[:friend_circle][:member_ids].map do | member_id |
          FriendCircleMembership.new(:member_id => member_id)
         end
         friend_circle.save
         friend_circle_memberships.each do | membership |
           membership.friend_circle = friend_circle
           membership.save
         end
      end
      raise "Invalid" unless friend_circle.valid? && friend_circle_memberships.all? { |memberhsip| membership.valid? }
    rescue
      redirect_to new_friend_circle_url
    else
      redirect_to friend_circle
    end
    redirect_to current_user
  end
  
  def edit
  end
  
  def update
  end
  
  def show
    @friend_circle = FriendCircle.find(params[:id])
  end
  
  def index
  end
  
  def destroy
  end
end
