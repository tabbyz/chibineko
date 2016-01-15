class User < ActiveRecord::Base
  has_many :tests
  has_many :team_users
  has_many :teams, :through => :team_users
  validates :email, length: { maximum: 255 }
  validates :username, length: { maximum: 255 }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :confirmable

  def display_name
    s = username
    s ||= email
  end
end
