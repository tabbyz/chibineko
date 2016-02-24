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

    unless @project.save
      render json: format_error_message(@project), status: :unprocessable_entity
    end
  end

  def update
    unless @project.update(project_params)
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
      if team.nil?
        routing_error
      elsif !team.authorized?(current_user)
        forbidden_error
      end

      @project = team.projects.find_by(name: params[:project_name])
      routing_error if @project.nil?
    end

    def project_params
      params.require(:project).permit(:name, :user_id, :team_id)
    end
end