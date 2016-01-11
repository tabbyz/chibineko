class Team < ActiveRecord::Base
  has_many :projects, :dependent => :destroy
  has_many :team_users, :dependent => :destroy
  has_many :users, :through => :team_users
  belongs_to :user
  before_save { self.name = name.downcase }
  validates :name,
    presence: true,
    uniqueness: true,
    length: { in: 6..30 },
    format: { with: /\A[a-z0-9_]+\z/i }

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
