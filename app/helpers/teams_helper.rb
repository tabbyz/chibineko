module TeamsHelper
  def team_collection
    current_user.teams  # TODO: Also an authorized team
  end

  def current_team
    if current_controller == "tests"
      current_project.team if current_project
    else
      team_name = params[:name]
      team_name ||= params[:team_name]
      Team.find_by(name: team_name)
    end
  end
end
