class ChangeFriendIdToMemberIdInFriendCircleMembership < ActiveRecord::Migration
  def change
    rename_column :friend_circle_memberships, :friend_id, :member_id
  end
end
