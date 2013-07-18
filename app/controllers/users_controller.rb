class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
  end

  def profile_master
    redirect_to user_path(current_user.id)
  end
end
