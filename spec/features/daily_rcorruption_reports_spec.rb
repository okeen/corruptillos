require "rails_helper"

RSpec.feature "Daily Corruption Reports Listing", :type => :feature do
  fixtures(:daily_corruption_reports)
  fixtures(:users)

  let(:user) { users("basic_user") }

  before do
    CorruptionCase.first.update user_id: user.id
  end

  scenario "View all daily corruption reports" do
    visit daily_corruption_reports_path

    within 'table#daily_corruption_reports' do
      DailyCorruptionReport.all.each do |report|
        within "tr#daily_corruption_report_#{report.id}" do
          expect(page).to have_selector "td", text: report.day
          expect(page).to have_selector "td", text: report.total_cases
          expect(page).to have_selector "td", text: report.total_stolen_amount
          expect(page).to have_selector "td", text: report.csv_file.url
        end
      end
    end
  end

  scenario "Visit show page of a daily report" do
    report = DailyCorruptionReport.last

    visit daily_corruption_report_path(report)

    expect(page).to have_selector "p", text: "Total cases: #{report.total_cases}"
    expect(page).to have_selector "p", text: "Total stolen: #{report.total_stolen_amount}"

    within '#corruption_cases' do
      report.corruption_cases.each do |corruption_case|
        within "tr#corruption_case_#{corruption_case.id}" do
          expect(page).to have_selector "td", text: corruption_case.name
          expect(page).to have_selector "td", text: corruption_case.user&.email
          expect(page).to have_selector "td", text: corruption_case.stolen_amount
        end
      end
    end
  end
end