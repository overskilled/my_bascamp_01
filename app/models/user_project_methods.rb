module UserProjectMethods

  def allUserProject(user_id)
    # Fetch all projects associated with the user
    Project.where('projects.creator_id = :user_id OR (project_users.user_id = :user_id AND projects.creator_id <> :user_id)',
                user_id: user_id)
  end

  def createdByMe(user_id)
    # Fetch projects created by the user
    Project.where(creator_id: user_id)
  end

  def sharedWithMe(user_id)
    # Fetch projects shared with the user (excluding the projects created by the user)
    Project.joins(:project_users).where('project_users.user_id = ? AND projects.creator_id <> ?', user_id, user_id)
  end
end
