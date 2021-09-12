namespace :reports do
  task :daily => :environment do
    CorruptionReportDeliveryJob.perform_now(Date.today)
  end
end
