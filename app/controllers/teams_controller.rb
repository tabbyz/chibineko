class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    # @teams = Team.all
    @teams = Team.find_by_user(current_user)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
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
    # @team = Team.new(team_params)
    @team = current_user.teams.build(team_params)
    @team.save

    # respond_to do |format|
    #   if @team.save
    #     format.html { redirect_to @team, notice: 'Team was successfully created.' }
    #     format.json { render :show, status: :created, location: @team }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @team.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Team was successfully destroyed.' }  # TODO: redirect_to dashboards_path
      format.json { head :no_content }
    end
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
end
