class UserController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show
    @user = User.find(params[:id])
  end

  def set_role
    @user = User.find(current_user.id)
    @user.role = (@user.user?) ? 'admin' : 'user'
    @user.save
    redirect_to root_path
  end

end
