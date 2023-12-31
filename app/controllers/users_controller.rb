class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]


  def index
    render layout: false
  end

  def show
    @user = User.find(params[:id])
    @all_user_projects = @user.allUserProject(@user.id)
    @created_by_me_projects = @user.createdByMe(@user.id)
    @shared_with_me_projects = @user.sharedWithMe(@user.id)
  end

  def welcome
    @user = current_user
    @all_user_projects = @user.allUserProject(@user.id)
    @created_by_me_projects = @user.createdByMe(@user.id)
    @shared_with_me_projects = @user.sharedWithMe(@user.id)
    @projects = @user.createdByMe(@user.id) + @user.project_users.joins(:project).where.not(projects: { creator_id: @user.id }).map(&:project)
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
    flash[:primary] = "Joined project: #{project.name} with role: #{role.capitalize}."
    redirect_to @user
  end

end
