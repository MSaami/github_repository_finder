require 'rails_helper'

RSpec.describe RepositoriesController, type: :controller do
  let(:repository_finder) { double(:repository_finder) }

  before do
    allow(RepositoryFinder).to receive(:call).and_return(repository_finder)
  end

  context "response with correct params" do
    it "returns success response" do
      get :index, params: {q: 'Rails'}
      expect(response).to have_http_status(:ok)
    end
  end

  context "response with incorrect params" do
    it "returns success repsponse when params is nil" do
      get :index, params: {}
      expect(response).to have_http_status(:ok)
    end

    it "returns success response when params is empty string" do
      get :index, params: {q: '   '}
      expect(response).to have_http_status(:ok)
    end
  end
end
