class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user, presence: true
  validates :user, uniqueness: {scope: :project, message: "has already been added"}

  before_destroy :check_owners

  def owners
    project.memberships.where(role: "Owner")
  end

  def check_owners
    if owners.count == 1 && role == "Owner"
      return false
    end
  end
end
