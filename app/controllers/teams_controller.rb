class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_team!, except: [:index, :new, :create]

  def index
    @teams = Team.find_by_user(current_user)
  end

  def show
    project = @team.projects.first
    redirect_to team_project_path(@team, project) if project
  end

  def new
    @team = current_user.teams.build if user_signed_in?
  end

  def edit
  end

  def create
    @team = current_user.teams.build(team_params)
    @team.user_id = current_user.id
    if @team.save
      @team.authorized!(current_user)
    else
      render json: format_error_message(@team), status: :unprocessable_entity
    end
  end

  def update
    if @team.update(team_params)
      # Do nothing
    else
      render json: format_error_message(@team), status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
    redirect_to dashboard_path, notice: t("teams.messages.destroy")
  end

  def settings
  end

  private
    def authenticate_team!
      @team = Team.find_by(name: params[:name])
      if @team.nil?
        routing_error 
      elsif !@team.authorized?(current_user)
        forbidden_error
      end
    end

    def team_params
      params.require(:team).permit(:name)
    end
end