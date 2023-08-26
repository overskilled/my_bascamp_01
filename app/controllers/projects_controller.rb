class ProjectsController < ApplicationController

  def index
    #@projects = Project.all
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
      # Create a project_user record for the creator with role "admin"
      ProjectUser.create(user: current_user, project: @project, role: 'admin')
      flash[:success] = "Project created successfully."
      redirect_to project_path(@project)
    else
      flash.now[:error] = "Project creation failed"
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(params.require(:project).permit(:name, :description))
      flash[:success] = "Project successfully updated!"
      redirect_to project_path(@project)
    else
      flash.now[:error] = "Project update failed"
      render :edit
    end
  end

  def add_user
    @project = Project.find(params[:id])
    user = User.find_by(email: params[:email])
    role = params[:role]

    if role == 'admin' || role == 'user'
      if @project.users.include?(user)
        flash[:error] = "#{user.username} is already a member of the project."
      else
        ProjectUser.create(user: user, project: @project, role: role)
        flash[:success] = "Project shared with #{user.username} as a #{role}."
      end
    else
      flash[:error] = "Invalid role. Please select 'admin' or 'user'.#{role}"
    end

    redirect_to @project
  end

  def update_role
    @project = Project.find(params[:id])
    user = User.find(params[:user_id])
    new_role = params[:role]

    project_user = @project.project_users.find_by(user: user)
      if project_user
        project_user.update(role: new_role)
        flash[:success] = "#{user.username}' role has been updated."
        redirect_to edit_project_path(@project)
      else
        flash[:error] = "Failed to update user's role."
        redirect_to edit_project_path(@project)
      end
  end



  def delete
    @project = Project.find(params[:id])
    @project.destroy
    flash[:success] = "Project deleted successfully."
    redirect_to home_welcome_path
  end

  protected

  def permitted_params
    params.require(:project).permit(:name, :description)
  end
end
