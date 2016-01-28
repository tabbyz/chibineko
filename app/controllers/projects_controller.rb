class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_project!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @tests = @project.tests
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    
    team = Team.find_by(name: params[:team_name])
    @project.team_id = team.id

    if @project.save
      # Do nothing
    else
      render json: format_error_message(@project), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      # Do nothing
    else
      render json: format_error_message(@project), status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to team_path(params[:team_name]), notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      team = Team.find_by(name: params[:team_name])
      @project = team.projects.find_by(name: params[:project_name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :user_id, :team_id)
    end

    def authenticate_project!
      team = Team.find_by(name: params[:team_name])
      redirect_to root_url unless team.authorized?(current_user)  # TODO: Redirect to 404 page
    end
end
