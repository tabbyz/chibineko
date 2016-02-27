module TeamsHelper
  def current_team
    if team_name = params[:name] || params[:team_name]
      Team.find_by(name: team_name)  
    elsif current_test
      current_test.try(:project).try(:team) 
    end
  end
end
