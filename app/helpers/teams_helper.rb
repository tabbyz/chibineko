module TeamsHelper
  def team_collection
    current_user.teams  # TODO: Also an authorized team
  end

  def current_team
    team_name = params[:name]
    team_name ||= params[:team_name]
    if team_name
      Team.find_by(name: team_name)  
    else
      current_test.project.team if current_test  
    end
  end
end
