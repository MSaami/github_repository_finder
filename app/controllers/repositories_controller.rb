class RepositoriesController < ApplicationController
  def index
    @repositories = RepositoryFinder.call(params[:q])
  end
end
