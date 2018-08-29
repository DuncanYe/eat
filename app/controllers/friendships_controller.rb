class FriendshipsController < ApplicationController

  def create
    current_user.friendships.create!(friend_id: params[:friend_id])
    redirect_back(fallback_location: root_path)
  end
end
