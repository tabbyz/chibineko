class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_project!, except: [:index, :new, :create]

  def index
    @projects = Project.all
  end

  def show
    @tests = @project.tests
  end

  def new
    @project = Project.new
  end

  def edit
  end

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

  def update
    if @project.update(project_params)
      # Do nothing
    else
      render json: format_error_message(@project), status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to team_path(params[:team_name]), notice: t("projects.messages.destroy")
  end

  def settings
  end

  private
    def authenticate_project!
      team = Team.find_by(name: params[:team_name])
      routing_error if team.nil? || !team.authorized?(current_user)

      @project = team.projects.find_by(name: params[:project_name])
      routing_error if @project.nil?
    end

    def project_params
      params.require(:project).permit(:name, :user_id, :team_id)
    end
end