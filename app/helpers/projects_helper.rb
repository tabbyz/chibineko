module ProjectsHelper
  def project_collection
    current_team.projects if current_team
  end

  def current_project
    if current_controller == "tests"
      test = Test.find_by(slug: params[:slug])
      test.project if test
    else
      current_team.projects.find_by(name: params[:project_name]) if current_team
    end
  end
end
