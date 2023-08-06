class Project < ApplicationRecord
  include UserProjectMethods

  #Associations
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  # Method to fetch all users associated with this project
  def allUserProject(user_id)
    # Fetch all projects associated with the user
    Project.joins(:project_users).where('project_users.user_id = ?', user_id)
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
