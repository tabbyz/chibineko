class Team < ActiveRecord::Base
  belongs_to :user

  class << self
    def find_by_user(user)
      user.teams  # TODO: Also an authorized team
    end
  end
  
  def to_param
    name
  end
end
