class RepositoriesController < ApplicationController
  def index
    @repositories = if params[:q].present?
      Octokit::Client.new.search_repositories(params[:q], per_page: 100).items
    else
      []
    end
  end
end
