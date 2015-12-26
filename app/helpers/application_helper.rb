module ApplicationHelper
  def current_controller
    params[:controller].parameterize
  end

  def current_action
    action_name
  end

  def current_controller_action
    current_controller + "#" + current_action
  end
end
