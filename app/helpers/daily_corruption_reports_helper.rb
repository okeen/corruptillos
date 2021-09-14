module DailyCorruptionReportsHelper
  def table_for_daily_corruption_reports(reports)
    table_for(reports, {}, :day, :total_cases, :stolen_amount, :csv_file, :actions)
  end

  def link_to_report_file
    button_link_to(t("actions.download"), @daily_corruption_report.csv_file.url, class: 'btn-primary')
  end
end
