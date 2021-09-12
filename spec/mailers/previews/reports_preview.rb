# Preview all emails at http://localhost:3000/rails/mailers/reports
class ReportsPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reports/user_corruption_cases
  def user_corruption_cases
    ReportsMailer.user_corruption_cases
  end

end
