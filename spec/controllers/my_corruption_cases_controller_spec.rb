require "rails_helper"

describe My::CorruptionCasesController, type: :controller do
  fixtures(:users)

  context "without a logged in user" do
    it "should have a current_user" do
      expect(subject.current_user).to be_blank
    end

    it "should get index" do
      get 'index'
      expect(response.status).to eq 302
    end
  end

  context "with a logged in user", has_users: true do
    it "should have a current_user" do
      expect(subject.current_user).to be_present
    end

    it "should get index" do
      get 'index'
      expect(response.status).to eq 200
    end
  end
end