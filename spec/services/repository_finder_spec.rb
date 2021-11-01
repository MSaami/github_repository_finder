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

  context "empty result" do
    it "returns empty array when query is nil" do
      repository_finder = described_class.call(nil)
      expect(repository_finder.count).to eq(0)
    end

    it "returns empty array when query is empty string" do
      repository_finder = described_class.call('  ')
      expect(repository_finder.count).to eq(0)
    end
  end
end
