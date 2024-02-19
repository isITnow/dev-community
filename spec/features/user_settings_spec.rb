require 'rails_helper'

RSpec.feature "UserSettings", type: :feature do
  describe "User Settings" do
    before :each do
      @user = create :user
      sign_in @user
      visit "/member/#{@user.id}"
    end

    it "should allow users to edit their personal information" do
      expect(page).to have_text(@user.name) 
      expect(page).to have_text(@user.profile_title) 
      expect(page).to have_text(@user.address) 
      expect(page).to have_text("e-mail: #{@user.email}") 
      expect(page).to have_text('About')
      expect(page).to have_text(@user.about)

      find(:xpath, '//a[contains(@class, "edit-profile")]//i[contains(@class, "bi-pencil-fill")]').click

      expect(page).to have_text('Edit your personal details') 

      fill_in 'user_first_name',	with: 'Leonardo' 
      fill_in 'user_last_name',	with: 'The Turtle' 
      fill_in 'user_city',	with: 'New York' 
      fill_in 'user_state',	with: 'New York' 
      fill_in 'user_country',	with: 'USA' 
      fill_in 'user_pincode',	with: '11004-05' 
      fill_in 'user_profile_title',	with: 'Ninja Turtles Squad Leader'
      click_button 'Save Changes'
      sleep 2

      expect(page).to have_current_path("/member/#{@user.id}")
      expect(page).to have_text('Leonardo The Turtle') 
      expect(page).to have_text('Ninja Turtles Squad Leader') 
      expect(page).to have_text('New York, New York, USA, 11004-05') 
    end

    it "should allow users to edit their about information" do
      expect(page).to have_text('About')
      expect(page).to have_text(@user.about)

      find(:xpath, '//a[contains(@class, "edit-about")]//i[contains(@class, "bi-pencil-fill")]').click

      expect(page).to have_text('Edit your description') 
      expect(page).to have_text(@user.about) 

      fill_in 'user_about',	with: 'On branch main Your branch is ahead of "origin/main" by 3 commits. (use "git push" to publish your local commits)'
      click_button 'Save Changes'
      sleep 2

      expect(page).to have_current_path("/member/#{@user.id}")
      expect(page).to have_text('About') 
      expect(page).to have_text('On branch main Your branch is ahead of "origin/main" by 3 commits. (use "git push" to publish your local commits)')
    end
  end
end
