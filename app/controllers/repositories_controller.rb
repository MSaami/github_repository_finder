class RepositoriesController < ApplicationController
  def index
    @repositories = if params[:q].present?
                      RepositoryFinder.call(params[:q])
                    else
                      []
                    end
  end
end
