class ReportsMailer < ApplicationMailer

  def user_corruption_cases(user, csv_file)
    @user = user

    file_name = "corruption-cases-#{Date.today.to_s}"
    attachments[file_name] = { mime_type: 'text/csv', content: csv_file }

    mail to: user
  end
end
