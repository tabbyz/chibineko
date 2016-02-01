class UserSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]

  def edit
  end

  def update
    sleep 1  # TODO: debug
    if @user.update(user_params)
      # Do nothing
    else
      render json: @user.errors.messages, status: :unprocessable_entity
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
