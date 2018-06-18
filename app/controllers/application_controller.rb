class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Get out of here"
      redirect_to root_path
    end
  end
end
