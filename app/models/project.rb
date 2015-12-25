class Project < ActiveRecord::Base
  belongs_to :team

  def to_param
    name
  end
end
