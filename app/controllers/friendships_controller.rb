class FriendshipsController < ApplicationController

  def create
     @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "加好友了！"
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence 
    end
    redirect_back(fallback_location: root_path)
  end
end
