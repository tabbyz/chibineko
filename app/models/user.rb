class User < ActiveRecord::Base
  has_many :tests
  has_many :team_users
  has_many :teams, :through => :team_users
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def display_name
    s = username
    s ||= email
  end
end
