class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  

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

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :intro)
  end

end
