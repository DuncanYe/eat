class RestaurantsController < ApplicationController
  
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
  
end
