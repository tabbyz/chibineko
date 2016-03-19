class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tests = current_user.tests.includes(:project, project: [:team])
  end
end
