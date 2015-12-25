module ApplicationHelper
  def current_controller
    params[:controller].parameterize
  end

  def current_action
    action_name
  end
end
