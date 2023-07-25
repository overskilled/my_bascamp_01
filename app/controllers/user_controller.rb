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

  def join_project
    @user = User.find(params[:id])
    project_id = params[:project_id]
    role = params[:role]

    project = Project.find(project_id)

    # Create the association between the user and project with the specified role
    @user.projects << project
    project_user = project.project_users.find_by(user: @user)
    project_user.update(role: role)

    redirect_to @user, notice: "Joined project: #{project.name} with role: #{role.capitalize}."
  end

end
