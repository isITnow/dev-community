require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  # create a shared example
  shared_examples 'a successful login' do |login_field|
    let(:user) { create(:user) }
    it "should log in user with #{login_field}" do
      visit root_path

      fill_in "user_login",	with: user.send(login_field)
      fill_in "user_password",	with: user.password

      click_button 'Log In'
      expect(page).to have_link('Dev Community')
      expect(page).to have_link(user.username)
      expect(page).to have_link('My Network')
      expect(page).to have_link('Sign Out')
      expect(page).to have_text('Search professionals across the world!')
      expect(page).to have_text(user.name)
      expect(page).to have_text(user.profile_title)
    end
  end

  describe "login" do
    # call the shared examples
    include_examples 'a successful login', :username
    include_examples 'a successful login', :email
  end
end
