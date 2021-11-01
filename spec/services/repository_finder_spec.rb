require 'rails_helper'

RSpec.describe RepositoryFinder do
  let(:repository1) {double(:repository, full_name: 'rails', stargazers_count: 45, description: 'test', html_url: 'http://test.com')}
  let(:repository2) {double(:repository, full_name: 'vim-rails', stargazers_count: 50, description: 'test', html_url: 'http://test.com')}
  let(:octokit_mock) { double(:client, search_repositories: double(:response, items: [repository1, repository2]))}

  before do
    allow(Octokit::Client).to receive(:new).and_return(octokit_mock)
  end

  context "correct result" do
    it "returns correct repositories" do
      repository_finder = described_class.call('rails')
      expect(repository_finder.count).to eq(2)
      expect(repository_finder.first.name).to eq('rails')
      expect(repository_finder.last.name).to eq('vim-rails')
    end
  end
end
