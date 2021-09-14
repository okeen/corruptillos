require 'rails_helper'

RSpec.describe CorruptionReportDeliveryJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(report) }
  let(:report) { DailyCorruptionReport.create(day: Date.today, total_stolen: 0) }

  describe "perform" do
    let(:a_mock) { double('something', deliver_later: nil)}
    before do
      allow(ReportsMailer).to receive(:user_corruption_cases).and_return(a_mock)
    end

    it 'Invokes ReportMailer for every valid destinatary' do
      User.all.each do |user|
        expect(ReportsMailer).to receive(:user_corruption_cases).with(user, report)
      end
      perform_enqueued_jobs { job }
    end

    context "with an empty report" do
      subject(:job) { described_class.perform_later(nil) }

      it 'returns via the guard clause' do
        expect(ReportsMailer).not_to receive(:user_corruption_cases)
        perform_enqueued_jobs { job }
      end
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
