require "rails_helper"

RSpec.feature "User registration and session", :type => :feature do
  fixtures(:users)
  let(:user_attributes) { { name: 'Me', email: 'a@c.com', password: 'Ch4ng3M3!' } }

  scenario "Register with an email, name and password" do
    visit new_user_registration_path

    within 'form#new_user' do
      fill_in 'Email', with: user_attributes[:email]
      fill_in 'Name', with: user_attributes[:name]
      fill_in 'Password', with: user_attributes[:password]
      fill_in 'Password confirmation', with: user_attributes[:password]

      expect {
        click_button "Sign Up"
        sleep(0.1)
      }.to change{ User.count }.by(1)
    end

    user = User.last
    expect(user.name).to eq user_attributes[:name]
    expect(user.email).to eq user_attributes[:email]
  end
end