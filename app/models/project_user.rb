class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project

  # Add the 'role' attribute as an enum
  enum role: { user: 0, admin: 1 }
end
