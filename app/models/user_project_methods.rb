module UserProjectMethods
  def allUserProject(user_id)
    # Fetch all projects associated with the user
    Project.where('project_users.user_id = ? OR (projects.creator_id = ? AND project_users.role = ?)', id, id, 'admin')
  end

  def createdByMe(user_id)
    # Fetch projects created by the user
    Project.where(creator_id: user_id)
  end

  def sharedWithMe(user_id)
    # Fetch projects shared with the user (excluding the projects created by the user)
    Project.joins(:project_users).where('project_users.user_id = ? AND project_users.role = ?', user_id, 'user')
  end
end
