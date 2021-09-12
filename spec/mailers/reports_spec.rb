require "rails_helper"

RSpec.describe ReportsMailer, type: :mailer do
  describe "user_corruption_cases" do
    let(:mail) { ReportsMailer.user_corruption_cases }

    it "renders the headers" do
      expect(mail.subject).to eq("User corruption cases")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
