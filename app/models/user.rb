class User < ActiveRecord::Base
  has_many :teams
  has_many :tests
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def display_name
    s = username
    s ||= email
  end
end
