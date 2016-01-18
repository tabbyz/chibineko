module StaticPagesHelper
  def page_title(title)
    app_name = Chibineko
    if title.blank?
      "#{app_name}: The simplest test supporting tool"
    else
      "#{title} | #{app_name}"
    end
  end
end
