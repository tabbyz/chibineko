module ProjectsHelper
  def project_collection
    current_team.projects if current_team
  end

  def current_project
    current_team.projects.find_by(name: params[:project_name]) if current_team
  end
end
