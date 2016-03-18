class CollaboratorsController < ApplicationController
  include Pundit
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.new
    @users = User.all
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(user_id: params[:user_id])
    if @collaborator.save
      redirect_to wikis_path, notice: 'Wiki shared.'
    else
      flash[:error] = 'Error creating wiki. Try again.'
      render :new
    end
     end
end
