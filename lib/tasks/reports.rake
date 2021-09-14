namespace :reports do
  namespace :daily do
    task :create => :environment do
      DailyCorruptionReportCreationService.new(Date.today).create_report
    end

    task :notify_users => :environment do
      CorruptionReportDeliveryJob.perform_now(Date.today)
    end
  end
end
