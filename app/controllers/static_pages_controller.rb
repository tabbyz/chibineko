class StaticPagesController < ApplicationController
  def top
    @user = User.new
  end

  def terms
  end
end
