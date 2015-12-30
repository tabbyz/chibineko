module ProjectsHelper
  def project_collection
    current_team.projects if current_team
  end

  def current_project
    project_name = params[:project_name]
    if project_name
      Project.find_by(name: project_name)
    else
      current_test.project if current_test
    end
  end
end
