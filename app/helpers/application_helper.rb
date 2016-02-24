module ApplicationHelper
  def controller_action
    controller_name + "#" + action_name
  end

  def color_names
    %w(red pink purple deeppurple indigo blue cyan teal green lightgreen lime yellow amber orange deeporange brown gray bluegray lightgray white)
  end

  def page_title(title)
    if title.blank?
      "Chibineko: #{I18n.t('.static_pages.top.branding.title')}"
    else
      "#{title} | Chibineko"
    end
  end
end
