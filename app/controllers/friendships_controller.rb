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

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship.destroy
    flash[:alert] = "刪除好友"
    redirect_back(fallback_location: root_path)
  end
end
