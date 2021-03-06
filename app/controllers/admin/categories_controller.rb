class Admin::CategoriesController < Admin::BaseController
  before_action :find_category, only: [:update, :destroy]

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
    if @category.update(category_params)
      flash[:notice] = "更新分類成功"
      redirect_to admin_categories_path
    else
      flash[:alert] = "分類更新有誤！！"
      @categories = Category.all
      render :index
    end
  end

  def destroy
    @category.destroy
    flash[:alert] = "分類已刪除"
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end

end
