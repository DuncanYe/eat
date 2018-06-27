class CommentsController < ApplicationController
  before_action :find_restaurant

  def create
    @comment = @restaurant.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to restaurant_path(@restaurant), notice: "留言成功"
    else
      # redirect_to request.referrer, alert: "Comment不得為空白"
      # redirect_to restaurant_path(@restaurant), alert: "Comment不得為空白"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user.admin?
      @comment.destroy
      redirect_to restaurant_path(@restaurant), alert: "留言已刪除"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end
