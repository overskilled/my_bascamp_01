class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    @projects = current_user.allUserProject
  end

  def show
    @project = Project.find(params[:id]);
    @shared_users = @project.users
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(permitted_params)
    @project.creator = current_user

    if @project.save
      redirect_to project_path(@project), notice: "Project created successfully."
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update

  end

  def add_user
    @project = Project.find(params[:project_id])
    user = User.find_by(email: params[:email])
    role = params[:admin] == "yes" ? "admin" : "user"

    if user
      if @project.users.include?(user)
        redirect_to @project, alert: "#{user.username} is already a member of the project."
      else
        @project.users << user
        project_user = @project.project_users.find_by(user: user)
        project_user.update(role: role)
        redirect_to @project, notice: "#{user.username} has been added to the project as a #{role}."
      end
    else
      redirect_to @project, alert: "User with the provided email not found."
    end
  end


  def share
    @project = Project.find(params[:id])
    user = User.find(params[:user_id])
    role = params[:role]

    if role == "admin" || role == "user"
      @project.users << user
      project_user = @project.project_users.find_by(user: user)
      project_user.update(role: role)
      redirect_to @project, notice: "Project shared with #{user.username} as a #{role}."
    else
      redirect_to @project, alert: "Invalid role. Please select 'admin' or 'user'."
    end
  end

  protected

  def permitted_params
    params.require(:project).permit(:name, :description)
  end
end
