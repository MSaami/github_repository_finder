class RepositoryFinder
  PER_PAGE = 100
  def self.call(*args)
    new(Octokit::Client.new).search(*args)
  end

  def initialize(client)
    @client = client
  end

  def search(query)
    items = @client.search_repositories(query, per_page: PER_PAGE).items
    map_items(items)
  end

  private
  def map_items(items)
      items.map { |item| Repository.new(
        name: item.full_name,
        description: item.description,
        star: item.stargazers_count,
        url: item.html_url
      )}

  end
end
