require 'rails_helper'

RSpec.describe "Search through github repositories", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:repository) {double(:repository, full_name: "vim-rails", description: "test description", stargazers_count: 43, html_url: "http://test.com")}
  let(:octokit_response_mock) { double(:response, items: [repository])}

  before do
    allow_any_instance_of(Octokit::Client).to receive(:search_repositories).and_return(octokit_response_mock)
  end

  it "can search through github repsitories" do
    visit "/"
    fill_in "q", with: "rails"
    click_button "Search"
    expect(page).to have_text('vim-rails')
    expect(page).to have_text('test description')
    expect(page).to have_link(href: 'http://test.com')
  end
end
