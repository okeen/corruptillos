require "rails_helper"

RSpec.feature "Corruption cases CRUD", :type => :feature do
  fixtures(:corruption_cases)

  let(:case_attributes) { corruption_cases("guilty_case").attributes.reject!{ |k, v| k == "id" }.with_indifferent_access }

  scenario "Create a new case" do
    visit "/corruption_cases/new"

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
end