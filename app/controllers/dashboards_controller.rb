class DashboardsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tests = current_user.tests
  end
end
