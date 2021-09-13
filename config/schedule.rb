every 1.day, at: '8:00 am' do
  rake "reports:daily:create"
  rake "reports:daily:notify"
end