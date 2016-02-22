class UserSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]

  def edit
  end

  def update
    unless @user.update(user_params)
      render json: format_error_message(@user), status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:username, :timezone, :locale)
    end
end
