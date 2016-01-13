class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale, :set_timezone

  private
    def set_locale
      client_locale = http_accept_language.compatible_language_from(I18n.available_locales)

      if current_user
        locale = current_user.locale
        if locale.nil?
          locale = client_locale
          current_user.update(locale: locale)
        end
      else
        locale = client_locale
      end
      
      I18n.locale = locale
    end

    def set_timezone
      client_tz = Time.zone.name

      if current_user
        tz = current_user.timezone
        if tz.nil?
          tz = client_tz
          current_user.update(timezone: tz)
        end
      else
        tz = client_tz
      end
      
      Time.zone = tz
  end
end
