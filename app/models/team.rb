class Team < ActiveRecord::Base
  has_many :projects, :dependent => :destroy
  has_many :team_users, :dependent => :destroy
  has_many :users, :through => :team_users
  belongs_to :user
  before_save { self.name = name.downcase }
  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { in: 4..30 },
    format: { with: /\A[a-z0-9_]+\z/i }
  default_scope { order("id ASC") }

  def authorized?(user)
    user && self.team_users.find_by(user_id: user.id) ? true : false
  end

  def authorized!(user)
    self.team_users.create(team_id: self.id, user_id: user.id)
  end
  
  def to_param
    name
  end
end
