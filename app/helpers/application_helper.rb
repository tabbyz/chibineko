module ApplicationHelper
  def controller_action
    controller_name + "#" + action_name
  end

  def color_names
    %w(red pink purple deeppurple indigo blue cyan teal green lightgreen lime yellow amber orange deeporange brown gray bluegray lightgray white)
  end
end
