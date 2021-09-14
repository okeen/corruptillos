require 'csv'

class DailyCorruptionReportCreationService
  attr_reader :day

  def initialize(day)
    @day = day
  end

  def create_report
    report = DailyCorruptionReport.find_or_create_by(day: day)
    report.csv_file = csv_content(report)
    report.save

    return report
  end

  def csv_content(report)
    csv = CSV.open("tmp/cases-#{Time.now}.csv", "w+")

    csv << [:user_id, :name, :stolen_amount, :place]
    report.corruption_cases.find_each do |corruption_case|
      csv << csv_entry(corruption_case)
    end

    csv.rewind
    csv
  end

  def csv_entry(corruption_case)
    [
      corruption_case.user_id,
      corruption_case.name,
      corruption_case.stolen_amount,
      corruption_case.place
    ]
  end
end