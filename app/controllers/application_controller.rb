class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale

  private
    def set_locale
      client_locale = http_accept_language.compatible_language_from(I18n.available_locales)
      client_locale ||= I18n.default_locale

      if current_user
        locale = current_user.locale
        if locale.blank?
          locale = client_locale
          current_user.update(locale: locale)
        end
      else
        locale = client_locale
      end
      
      I18n.locale = locale
    end
end
