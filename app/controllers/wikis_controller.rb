class WikisController < ApplicationController
  include Pundit

  before_action :authorize_user, except: [:index, :show, :new, :create]
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @users = User.all
    @wiki = Wiki.new
  end

  def edit
    @users = User.all
    @wiki = Wiki.find(params[:id])
    @collabs = @wiki.collaborators.map { |collaborator| collaborator.user_id }
    # render text: @collabs
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user
    # @wiki.collaborator_ids = params[:collaborator_ids]

    if @wiki.save
      flash[:notice] = 'Wiki was saved.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      # @wiki.collaborators.delete_all
      params[:collaborator_ids].each do |collab_id|
        Collaborator.create({user_id: collab_id, wiki_id: params[:id]})
      end
      flash[:notice] = 'Wiki was updated.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :edit
    end
   end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = 'There was an error deleting the wiki.'
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:name, :description, :public)
  end

  def authorize_user
    wiki = Wiki.find(params[:id])
    unless current_user.admin? || current_user == wiki.user || wiki.collaborators.include?(user)
      flash[:alert] = 'You must be an admin to do that.'
      redirect_to wikis_path
    end
  end
end
