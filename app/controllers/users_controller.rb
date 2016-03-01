class UsersController < ApplicationController
include Pundit
  def index
  end

  def show
    @user = User.find(params[:id])
  end
end
