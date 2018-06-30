class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:favorite, :unfavorite, :like, :unlike]
  
  def index
    @restaurants = Restaurant.order(created_at: :desc).page(params[:page]).per(9).includes(:category)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10).includes(:category)
    @recent_comments = Comment.order(created_at: :desc).limit(10).includes(:restaurant, :user)
  end

  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end

  def favorite
    @restaurant.favorites.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    favorite = Favorite.where(restaurant: @restaurant, user: current_user).first
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  def like
    @restaurant.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    like = @restaurant.likes.where(user: current_user).first
    like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
  
end
