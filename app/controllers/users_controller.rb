class UsersController < ApplicationController
include Pundit
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
