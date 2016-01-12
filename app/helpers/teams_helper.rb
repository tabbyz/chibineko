module TeamsHelper
  def current_team
    team_name = params[:name]
    team_name ||= params[:team_name]
    if team_name
      Team.find_by(name: team_name)  
    else
      current_test.try(:project).try(:team) if current_test
    end
  end
end
