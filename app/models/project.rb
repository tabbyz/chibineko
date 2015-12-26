class Project < ActiveRecord::Base
  belongs_to :team
  has_many :tests

  def to_param
    name
  end
end
