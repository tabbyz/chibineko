class TeamUsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @team = Team.find_by(name: params[:team_name])
    @team_users = @team.team_users
    @team_user = TeamUser.new
  end

  def create
    @team = Team.find_by(name: params[:team_name])
    user = User.find_by(email: params[:email])

    TeamUser.create(team_id: @team.id, user_id: user.id) unless TeamUser.find_by(team_id: @team.id, user_id: user.id)
    @team_users = @team.team_users
    @team_user = TeamUser.new
  end

  def destroy
    @team_user = TeamUser.find(params[:id])
    @team = @team_user.team
    @team_user.destroy
    @team_users = @team.team_users
    @team_user = TeamUser.new
  end

  def ajax_search_user
    @user = User.find_by(email: params[:email])
    render json: @user.present?
  end
end
