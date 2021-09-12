require 'rails_helper'

RSpec.describe CorruptionReportDeliveryJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(report) }

  let(:report) { DailyCorruptionReport.create(day: Date.today) }

  describe "perform" do
    let(:an_email) { instance_double(Mail::Message, deliver_later: nil)}

    before do
      allow(ReportsMailer).to receive(:user_corruption_cases).and_return(an_email)
    end

    it 'Invokes ReportMailer for every valid destinatary' do
      User.all.each do |user|
        expect(ReportsMailer).to receive(:user_corruption_cases).with(user, report)
      end
      perform_enqueued_jobs { job }
    end
  end

  describe "per_valid_destinatary" do
    context "with some existing users" do
      let(:spy) { double("something", foo: :bar) }

      it "calls the &block param for every active user" do
        job.send(:per_valid_destinatary) do |user|
          spy.foo(user)
        end

        User.all.each do |user|
          expect(spy).to have_received(:foo).with(user)
        end
      end
    end
  end
end
