class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize!, except: [:new, :create]

  def show
    if project = @team.projects.first
      redirect_to team_project_path(@team, project)
    end
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
    unless @team.update(team_params)
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
    def set_team
      @team = Team.find_by(name: params[:name])
      routing_error if @team.nil?
    end

    def authorize!
      @team || set_team
      forbidden_error unless @team.authorized?(current_user)
    end

    def team_params
      params.require(:team).permit(:name)
    end
end