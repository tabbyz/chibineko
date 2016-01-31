class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_team!, except: [:new, :create]
  before_action :set_team, only: [:show, :edit, :update, :destroy, :settings]

  # GET /teams
  # GET /teams.json
  def index
    # @teams = Team.all
    @teams = Team.find_by_user(current_user)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    project = @team.projects.first
    redirect_to team_project_path(@team, project) if project
  end

  # GET /teams/new
  def new
    # @team = Team.new
    @team = current_user.teams.build if user_signed_in?
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = current_user.teams.build(team_params)
    @team.user_id = current_user.id
    if @team.save
      @team.authorized!(current_user)
    else
      render json: format_error_message(@team), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    if @team.update(team_params)
      # Do nothing
    else
      render json: format_error_message(@team), status: :unprocessable_entity
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    redirect_to dashboard_path, notice: t("teams.messages.destroy")
  end

  def settings
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find_by(name: params[:name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end

    def authenticate_team!
      team = Team.find_by(name: params[:name])
      redirect_to root_url unless team.authorized?(current_user)  # TODO: Redirect to 404 page
    end
end
