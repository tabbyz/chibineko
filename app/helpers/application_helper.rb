module ApplicationHelper
  def controller_action
    controller_name + "#" + action_name
  end
end
