class CommentsController < ApplicationController

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = @restaurant.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to restaurant_path(@restaurant)
    else
      redirect_to request.referrer, alert: "Comment不得為空白"
      # redirect_to restaurant_path(@restaurant), alert: "Comment不得為空白"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
