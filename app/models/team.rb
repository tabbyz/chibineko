class Team < ActiveRecord::Base
  belongs_to :user
  has_many :projects, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :users, :through => :team_users

  class << self
    def find_by_user(user)
      user.teams  # TODO: Also an authorized team
      user.authorized_teams
    end
  end

  def authorized?(user)
    self.users.include?(user)
  end
  
  def to_param
    name
  end
end
