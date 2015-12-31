class Project < ActiveRecord::Base
  belongs_to :team
  has_many :tests, dependent: :destroy

  def to_param
    name
  end
end
