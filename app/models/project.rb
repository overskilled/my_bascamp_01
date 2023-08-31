class Project < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  include UserProjectMethods
  include UserProjects

  #Associations
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  #has_and_belongs_to_many :users

    # Method to fetch all projects associated with a specific user
    def self.allUserProject(user_id)
      joins(:users).where(users: { id: user_id })
    end

    # Method to fetch projects created by a specific user
    def self.createdByMe(user_id)
      where(creator_id: user_id)
    end

    # Method to fetch projects shared with a specific user (excluding projects created by the user)
    def self.sharedWithMe(user_id)
      joins(:users).where.not(creator_id: user_id).where(users: { id: user_id })
    end
end
