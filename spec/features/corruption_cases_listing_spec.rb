require "rails_helper"

RSpec.feature "Corruption cases listing", :type => :feature do
  fixtures(:corruption_cases)
  fixtures(:users)

  let(:user) { users("basic_user") }

  before do
    CorruptionCase.first.update user_id: user.id
  end

  scenario "View all the corruption cases" do
    visit corruption_cases_path

    within 'table#corruption_cases' do
      CorruptionCase.all.each do |corruption_case|
        within "tr#corruption_case_#{corruption_case.id}" do
          expect(page).to have_selector "td", text: corruption_case.name
          expect(page).to have_selector "td", text: corruption_case.stolen.format
          expect(page).to have_selector "td", text: corruption_case.place
          expect(page).to have_selector "td", text: corruption_case.trial_start_at.to_s
          expect(page).to have_selector "td", text: corruption_case.sentence
          expect(page).to have_selector "td", text: corruption_case.user&.email
        end
      end
    end
  end

  scenario "View the corruption cases of a user" do
    visit user_corruption_cases_path(user)

    within 'table#corruption_cases' do
      user.corruption_cases.each do |corruption_case|
        within "tr#corruption_case_#{corruption_case.id}" do
          expect(page).to have_selector "td", text: corruption_case.name
        end
      end

      CorruptionCase.where.not(user: user).each do |somebody_elses_case|
        expect(page).to have_no_selector "tr#corruption_case_#{somebody_elses_case.id}"
      end
    end
  end
end