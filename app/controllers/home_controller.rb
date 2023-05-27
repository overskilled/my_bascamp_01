class HomeController < ApplicationController
  before_action :authenticate_user!

  
  def index

  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def show
    @user = User.find(params[:id])
  end
end
