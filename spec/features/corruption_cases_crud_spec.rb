require "rails_helper"

RSpec.feature "Corruption cases CRUD", :type => :feature do
  fixtures(:corruption_cases)

  let(:case_attributes) { corruption_cases("guilty_case").attributes.reject!{ |k, v| k == "id" }.with_indifferent_access }
  let(:updated_case_attributes) do
    {
      name: 'Name changed',
      description: 'Description changed',
      stolen_amount: 500,
      place: 'Barcelona, Spain',
      trial_start_at: 2.years.ago,
      sentenced_at: 1.month.ago,
      sentence: 'pending',
      european_funds_project: '7654321'
    }
  end

  scenario "Create a new case" do
    visit new_corruption_case_path

    within "#new_corruption_case" do
      fill_in "Name", with: case_attributes[:name]
      fill_in "Description", with: case_attributes[:description]
      fill_in "Stolen amount", with: case_attributes[:stolen_amount]
      fill_in "Place", with: case_attributes[:place]
      fill_in "Trial start at", with: case_attributes[:trial_start_at]
      fill_in "Sentenced at", with: case_attributes[:sentenced_at]
      select 'guilty', from: 'Sentence'
      fill_in "European funds project", with: case_attributes[:european_funds_project]

      expect { click_button("Create Corruption case") }.to change { CorruptionCase.count }.by(1)
    end

    @new_case = CorruptionCase.last

    expect(@new_case.name).to eq case_attributes[:name]
    expect(@new_case.description).to eq case_attributes[:description]
    expect(@new_case.stolen_amount).to eq case_attributes[:stolen_amount]
    expect(@new_case.place).to eq case_attributes[:place]
    expect(@new_case.trial_start_at).to eq case_attributes[:trial_start_at]
    expect(@new_case.sentenced_at).to eq case_attributes[:sentenced_at]
    expect(@new_case.sentence).to eq case_attributes[:sentence]
    expect(@new_case.european_funds_project).to eq case_attributes[:european_funds_project]
  end

  scenario "View all the corruption cases" do
    visit corruption_cases_path

    within 'table#corruption_cases' do
      CorruptionCase.all.each do |corruption_case|
        within "tr#corruption_case_#{corruption_case.id}" do
          expect(page).to have_selector "td", text: corruption_case.name
          expect(page).to have_selector "td", text: corruption_case.stolen_amount
          expect(page).to have_selector "td", text: corruption_case.place
          expect(page).to have_selector "td", text: corruption_case.trial_start_at.to_s
          expect(page).to have_selector "td", text: corruption_case.sentence
        end
      end
    end
  end

  scenario "Update an existing corruption case" do
    @case = CorruptionCase.last
    visit edit_corruption_case_path(@case)

    within "#edit_corruption_case_#{@case.id}" do
      fill_in "Name", with: updated_case_attributes[:name]
      fill_in "Description", with: updated_case_attributes[:description]
      fill_in "Stolen amount", with: updated_case_attributes[:stolen_amount]
      fill_in "Place", with: updated_case_attributes[:place]
      fill_in "Trial start at", with: updated_case_attributes[:trial_start_at]
      fill_in "Sentenced at", with: updated_case_attributes[:sentenced_at]
      select 'pending', from: 'Sentence'
      fill_in "European funds project", with: updated_case_attributes[:european_funds_project]

      click_button("Update Corruption case")

      @case = @case.reload
      expect(@case.name).to eq updated_case_attributes[:name]
      expect(@case.description).to eq updated_case_attributes[:description]
      expect(@case.stolen_amount).to eq updated_case_attributes[:stolen_amount]
      expect(@case.place).to eq updated_case_attributes[:place]
      expect(@case.trial_start_at.to_date).to eq updated_case_attributes[:trial_start_at].to_date
      expect(@case.sentenced_at.to_date).to eq updated_case_attributes[:sentenced_at].to_date
      expect(@case.sentence).to eq updated_case_attributes[:sentence]
      expect(@case.european_funds_project).to eq updated_case_attributes[:european_funds_project]
    end
  end

  scenario "Delete an exisiting case", js: true do
    @case = CorruptionCase.last
    visit corruption_cases_path

    within "table#corruption_cases tr#corruption_case_#{@case.id}" do
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      sleep(0.01)
    end

    expect { @case.reload }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end