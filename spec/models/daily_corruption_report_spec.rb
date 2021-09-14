require 'rails_helper'

RSpec.describe DailyCorruptionReport, type: :model do
  fixtures(:corruption_cases)
  subject(:report) { described_class.new(total_stolen: 0) }

  describe "corruption_cases" do
    let(:query_spy) { instance_double(CorruptionCasesGroupbyUserQuery, inned_joined_and_ordered_by_user: 'something') }

    before do
      report.day = Date.today
      allow(CorruptionCase).to receive(:for_day).and_return(:something)
      allow(CorruptionCasesGroupbyUserQuery).to receive(:new).and_return(query_spy)
      report.send(:corruption_cases)
    end

    it "loads the daily cases from CorruptionCase#for_day" do
      expect(CorruptionCase).to have_received(:for_day).with(Date.today)
    end

    it "delegates the query into CorruptionCasesGroupbyUserQuery#inned_joined_and_ordered_by_user" do
      expect(query_spy).to have_received(:inned_joined_and_ordered_by_user)
    end
  end

  describe "save" do
    let(:cases) { CorruptionCase.all }

    before do
      allow(report).to receive(:corruption_cases).and_return(cases)
      subject.save
    end

    it "sets total_cases" do
      expect(subject.total_cases).to eq cases.count
    end

    it "sets total_stolen_amount" do
      expect(subject.total_stolen_amount).to eq cases.sum(:stolen_amount)
    end
  end
end
