class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  layout false

  def index

  end

  def welcome
    @user = User.find(current_user.id)
  end

  def after_sign_out_path_for(resource_or_scope)
    home_path
  end

  def show
    @user = User.find(current_user.id)
  end

  def user_set_role_path
    @user = User.find(current_user.id)
    @user.role = (@user.user?) ? 'admin' : 'user'
    @user.save
    redirect_to home_welcome_path
  end

end
