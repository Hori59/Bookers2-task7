class HomeController < ApplicationController
  before_action :baria_user, only: [:top]

  def top
  end

  def about
  end

  def baria_user
    if current_user
      redirect_to user_path(current_user)
    end
  end
end
