class FriendCircleMembership < ActiveRecord::Base
  attr_accessible :friend_circle_id, :member_id, :member_ids
  validates_presence_of :friend_circle_id, :member_id
  
  belongs_to :friend,
  :class_name => "User",
  :foreign_key => :member_id
  :primary_key => :id
  
  belongs_to :friend_circle
  
end
