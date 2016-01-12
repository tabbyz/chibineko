module ProjectsHelper
  def project_collection
    current_team.projects if current_team
  end

  def current_project
    team_name = params[:team_name]
    project_name = params[:project_name]
    if team_name && project_name
      team = Team.find_by(name: team_name)
      team.projects.find_by(name: project_name)
    else
      current_test.project if current_test
    end
  end
end
