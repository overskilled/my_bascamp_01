class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(permitted_params)
    if (@project.save)
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update

  end

  def share
    @project = Project.find(params[:id])
    user_id = params[:user_id]
    role = params[:role]

    user = User.find(user_id)

    # Create the association between the user and project with the specified role
    @project.users << user
    project_user = @project.project_users.find_by(user: user)
    project_user.update(role: role)

    redirect_to @project, notice: "Project shared with #{user.username}."
  end
  protected

  def permitted_params
    params.require(:project).permit(:name, :description)
  end
end
