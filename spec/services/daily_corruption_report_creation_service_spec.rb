require 'rails_helper'

RSpec.describe DailyCorruptionReportCreationService, type: :model do
  fixtures(:corruption_cases)
  subject(:service) { described_class.new(Date.today) }

  describe "create_report" do
    let(:report) { service.create_report }
    let(:uploader) { DailyCsvReportUploader.new }

    before do
      allow(service).to receive(:csv_content).and_return(uploader)
    end

    it "creates a report" do
      expect(report).to be_an_instance_of(DailyCorruptionReport)
      expect(report).to be_persisted
    end

    it "assigns the csv_file uploader" do
      expect(report.csv_file).to be_an_instance_of(DailyCsvReportUploader)
    end
  end

  describe "csv_entry" do
    context "for a given corruption case" do
      let(:a_case) { corruption_cases('guilty_case') }
      let(:result) { service.csv_entry(a_case) }

      it "returns the user_id as first item" do
        expect(result[0]).to eq a_case.user_id
      end

      it "returns the case name as second item" do
        expect(result[1]).to eq a_case.name
      end

      it "returns the stolen_amount as third item" do
        expect(result[2]).to eq a_case.stolen_amount
      end

      it "returns the place as fourth item" do
        expect(result[3]).to eq a_case.place
      end
    end
  end
end
