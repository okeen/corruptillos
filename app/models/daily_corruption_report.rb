class DailyCorruptionReport < ApplicationRecord
  mount_uploader :csv_file, DailyCsvReportUploader
  monetize :total_stolen_amount, as: :total_stolen, default: 0

  before_save :set_totals

  def corruption_cases
    cases_to_notify = CorruptionCase.for_day(day)
    CorruptionCasesGroupbyUserQuery.new(cases_to_notify).inned_joined_and_ordered_by_user
  end

  protected

  def set_totals
    current_corruption_cases = corruption_cases
    self.total_cases = current_corruption_cases.count
    self.total_stolen = Money.new(current_corruption_cases.sum(:stolen_amount))
  end
end
