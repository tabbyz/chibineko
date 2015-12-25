module TeamsHelper
  def team_collection
    current_user.teams  # TODO: Also an authorized team
  end

  def current_team
    Team.find_by(name: params[:team_name])
  end
end
