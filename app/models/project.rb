class Project < ActiveRecord::Base
  belongs_to :team
  has_many :tests, :dependent => :destroy
  before_save { self.name = name.downcase }
  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false, :scope => :team_id },
    length: { maximum: 30 },
    format: { with: /\A[a-z0-9_]+\z/i }
  default_scope { order("id ASC") }

  def to_param
    name
  end
end
