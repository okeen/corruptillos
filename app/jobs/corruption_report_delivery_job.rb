class CorruptionReportDeliveryJob < ApplicationJob
  queue_as :default
  attr_accessor :day

  def perform(report = nil)
    per_valid_destinatary do |user|
      ReportsMailer.user_corruption_cases(user, report).deliver_later
    end
  end

  protected

    def per_valid_destinatary(&block)
      User.all.find_each(&block)
    end
end
