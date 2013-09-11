class FriendCircle < ActiveRecord::Base
  attr_accessible :creator_id, :name
  validates_presence_of :creator_id, :name
  
  belongs_to :creator,
  :class_name => "User",
  :foreign_key => :creator_id,
  :primary_key => :id
  
  has_many :friend_circle_memberships
  
  has_many :members,
  :through => :friend_circle_memberships,
  :source => :friend
end
