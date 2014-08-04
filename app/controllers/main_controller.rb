class MainController < ApplicationController
  skip_before_action :ensure_current_user

  def about
    render :about
  end
end