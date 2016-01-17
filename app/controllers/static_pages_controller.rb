class StaticPagesController < ApplicationController
  def top
    @user = User.new
  end
end
