class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin

  def index
    @categories = Category.all

    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "成功建立新分類"
      redirect_to admin_categories_path
    else
      flash[:alert] = "分類建立有誤"
      @categories = Category.all
      render :index
      # render 會直接從Create action 直接去找view，不會經過index action
      # 所以要在給 @categories = Category.all
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "更新分類成功"
      redirect_to admin_categories_path
    else
      flash[:alert] = "分類更新有誤！！"
      @categories = Category.all
      render :index
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
