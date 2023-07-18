class UserController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show
    @user = User.find(params[:id])
  end

  def user_permission
    @user = User.find(params[:id])
    @user.role = 0
    @user.save
  end

  def admin_permission
    @user = User.find(params[:id])
    @user.role = 1
    @user.save
  end

end
