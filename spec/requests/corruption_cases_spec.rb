require 'rails_helper'

RSpec.describe "CorruptionCases", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/corruption_cases/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/corruption_cases/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/corruption_cases/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/corruption_cases/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/corruption_cases/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
