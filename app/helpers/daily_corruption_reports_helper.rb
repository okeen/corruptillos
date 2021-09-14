module DailyCorruptionReportsHelper
  def table_for_daily_corruption_reports(reports)
    table_for reports, {}, :day, :total_cases, :stolen_amount, :csv_file, :actions
  end
end
