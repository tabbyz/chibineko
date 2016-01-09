class Team < ActiveRecord::Base
  belongs_to :user
  has_many :projects, dependent: :destroy
  has_many :team_users, dependent: :destroy

  class << self
    def find_by_user(user)
      user.teams  # TODO: Also an authorized team
    end
  end
  
  def to_param
    name
  end
end
