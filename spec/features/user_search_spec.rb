require 'rails_helper'

RSpec.feature "UserSearches", type: :feature do
  describe "User search functionality" do
    before :each do
      @user = create :user
      sign_in @user
      
      @user1 = create(:user, country: 'Ukraine', city: 'Dnipro')
      @user2 = create(:user, country: 'Australia', city: 'Sydney')
      @user3 = create(:user, country: 'England', city: 'London')
      @user4 = create(:user, country: 'USA', city: 'New York')
      sleep 1
      visit root_path
    end

    describe 'search by country' do
      it 'should allow users to search other users by complete country name' do
        fill_in 'q_city_or_country_cont', with: 'Ukraine'
        click_button 'Search'

        expect(page).to have_text(@user1.name) 
        expect(page).to have_text(@user1.profile_title) 
        expect(page).to have_text(@user1.country) 

        expect(page).to_not have_text(@user2.country)  
        expect(page).to_not have_text(@user3.country)  
        expect(page).to_not have_text(@user4.country)  
      end

      it 'should allow users to search other users by partial country name' do
        fill_in 'q_city_or_country_cont', with: 'Aus'
        click_button 'Search'

        expect(page).to have_text(@user2.name) 
        expect(page).to have_text(@user2.profile_title) 
        expect(page).to have_text(@user2.country) 

        expect(page).to_not have_text(@user1.country)  
        expect(page).to_not have_text(@user3.country)  
        expect(page).to_not have_text(@user4.country)  
      end

      it 'should allow users to search other users by random character in the country name' do
        fill_in 'q_city_or_country_cont', with: 'a'
        click_button 'Search'

        expect(page).to have_text(@user2.name) 
        expect(page).to have_text(@user2.profile_title) 
        expect(page).to have_text(@user2.country) 
        expect(page).to have_text(@user1.name) 
        expect(page).to have_text(@user1.profile_title) 
        expect(page).to have_text(@user1.country) 
        expect(page).to have_text(@user3.name) 
        expect(page).to have_text(@user3.profile_title) 
        expect(page).to have_text(@user3.country) 
        expect(page).to have_text(@user4.name) 
        expect(page).to have_text(@user4.profile_title) 
        expect(page).to have_text(@user4.country) 
      end
    end

    describe 'search by city' do
      it 'should allow users to search other users by complete city name' do
        fill_in 'q_city_or_country_cont', with: 'Dnipro'
        click_button 'Search'

        expect(page).to have_text(@user1.name) 
        expect(page).to have_text(@user1.profile_title) 
        expect(page).to have_text(@user1.country) 

        expect(page).to_not have_text(@user2.country)  
        expect(page).to_not have_text(@user3.country)  
        expect(page).to_not have_text(@user4.country)  
      end

      it 'should allow users to search other users by partial city name' do
        fill_in 'q_city_or_country_cont', with: 'Syd'
        click_button 'Search'

        expect(page).to have_text(@user2.name) 
        expect(page).to have_text(@user2.profile_title) 
        expect(page).to have_text(@user2.country) 

        expect(page).to_not have_text(@user1.country)  
        expect(page).to_not have_text(@user3.country)  
        expect(page).to_not have_text(@user4.country)  
      end

      it 'should allow users to search other users by random character in the city name' do
        fill_in 'q_city_or_country_cont', with: 'n'
        click_button 'Search'

        expect(page).to have_text(@user2.name) 
        expect(page).to have_text(@user2.profile_title) 
        expect(page).to have_text(@user2.country) 
        expect(page).to have_text(@user1.name) 
        expect(page).to have_text(@user1.profile_title) 
        expect(page).to have_text(@user1.country) 
        expect(page).to have_text(@user3.name) 
        expect(page).to have_text(@user3.profile_title) 
        expect(page).to have_text(@user3.country) 
        expect(page).to have_text(@user4.name) 
        expect(page).to have_text(@user4.profile_title) 
        expect(page).to have_text(@user4.country) 
      end
    end

    describe 'search by invalid city or country' do
      it 'should return zero search results' do
        fill_in 'q_city_or_country_cont', with: 'xyz'
        click_button 'Search'

        expect(page).to_not have_text(@user1.country)  
        expect(page).to_not have_text(@user2.country)  
        expect(page).to_not have_text(@user3.country)  
        expect(page).to_not have_text(@user4.country)  
      end
    end
  end
end
