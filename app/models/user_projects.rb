module UserProjects
  extend ActiveSupport::Concern

  # Method to fetch all projects associated with a specific user
  def allUserProject(user_id)
    projects.joins(:users).where(users: { id: user_id })
  end

  # Method to fetch projects created by a specific user
  def createdByMe(user_id)
    projects.where(creator_id: user_id)
  end

  # Method to fetch projects shared with a specific user (excluding projects created by the user)
  def sharedWithMe(user_id)
    projects.joins(:users).where.not(creator_id: user_id).where(users: { id: user_id })
  end
end
