class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :follow, :unfollow]
  

  def index
    @users = User.all
  end

  def show
    @commented_restaurants = @user.restaurants.uniq
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def follow
    @followship = current_user.followships.build(following_id: params[:id])
    if @followship.save
      flash[:notice] = "追蹤了！"
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
    end
      redirect_back(fallback_location: root_path)
  end

  def unfollow
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    flash[:alert] = "刪除追蹤！"
    redirect_back(fallback_location: root_path)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :intro)
  end

end
