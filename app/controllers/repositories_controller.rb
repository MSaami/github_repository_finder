class RepositoriesController < ApplicationController
  def index
    @repositories = if params[:q].present?
      items = Octokit::Client.new.search_repositories(params[:q], per_page: 100).items
      items.map { |item| Repository.new(
        name: item.full_name,
        description: item.description,
        star: item.stargazers_count,
        url: item.html_url
      )}
    else
      []
    end
  end
end
