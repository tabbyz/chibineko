class TeamUser < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  default_scope { order("id ASC") }
end
