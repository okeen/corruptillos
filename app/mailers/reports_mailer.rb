class ReportsMailer < ApplicationMailer

  def user_corruption_cases(user, report)
    @user = user
    @report = report

    mail to: user
  end
end
