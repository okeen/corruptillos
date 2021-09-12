class DailyCorruptionCsvDeliveryJob < ApplicationJob
  queue_as :default
  attr_accessor :day

  def perform(day = nil)
    @day = day || Date.today

    per_valid_destinatary do |user|
      begin
        ReportsMailer.user_corruption_cases(user, csv_content).deliver
      rescue Exception => e
        Rails.logger.warn(e.backtrace)
        Rails.logger.warn(e.message)
      end
    end
  end

  protected

    def per_valid_destinatary(&block)
      User.all.find_each(&block)
    end

    def csv_content
      @_csv_content ||= CorruptionCasesCsvExportService.new(corruption_cases).csv_content
    end

    def corruption_cases
      @_corruption_cases ||= begin
        cases_to_notify = CorruptionCase.for_day(day)
        CorruptionCasesGroupbyUserQuery.new(cases_to_notify).inned_joined_and_ordered_by_user
      end
    end
end
