require 'rails_helper'

RSpec.describe DailyCorruptionCsvDeliveryJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_later(Date.today) }
  let(:csv_service_spy) { instance_double(CorruptionCasesCsvExportService, csv_content: 'something') }

  before do
    allow(CorruptionCasesCsvExportService).to receive(:new).and_return(csv_service_spy)
  end

  describe "perform" do
    it 'Invokes ReportMailer for every valid destinatary' do
      User.all.each do |user|
        expect(ReportsMailer).to receive(:user_corruption_cases).with(user, 'something')
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

  describe "csv_content" do
    it "returns what the service csv_content returns" do
      content = subject.send(:csv_content)
      expect(csv_service_spy).to have_received(:csv_content)
      expect(content).to eq 'something'
    end

    it "memorizes the value" do
      job.send(:csv_content)
      job.send(:csv_content)

      expect(CorruptionCasesCsvExportService).to have_received(:new).once
    end
  end

  describe "corruption_cases" do
    let(:query_spy) { instance_double(CorruptionCasesGroupbyUserQuery, inned_joined_and_ordered_by_user: 'something') }

    before do
      job.day = Date.today
      allow(CorruptionCase).to receive(:for_day).and_return(:something)
      allow(CorruptionCasesGroupbyUserQuery).to receive(:new).and_return(query_spy)
      job.send(:corruption_cases)
    end

    it "loads the daily cases from CorruptionCase#for_day" do
      expect(CorruptionCase).to have_received(:for_day).with(Date.today)
    end

    it "delegates the query into CorruptionCasesGroupbyUserQuery#inned_joined_and_ordered_by_user" do
      expect(query_spy).to have_received(:inned_joined_and_ordered_by_user)
    end
  end
end
