require 'rails_helper'

RSpec.feature "WorkExperiences", type: :feature do
  describe "Work Experiences" do
    describe "Current user" do
      before :each do
        @user = create :user
        sign_in @user
        visit "/member/#{@user.id}"
      end

      it "should open the work experience form
        and display the validation errors if empty form is submitted" do
        expect(page).to have_text('Work Experiences')
        find('a[data-controller="bs-modal-form"] i.bi.bi-plus').click
        expect(page).to have_text('Add new work experience')
        click_button('Save Changes')

        expect(page).to have_text('9 errors prohibited your work experience from being saved')
        expect(page).to have_text("Company can't be blank")
        expect(page).to have_text("Start date can't be blank")
        expect(page).to have_text("Job title can't be blank")
        expect(page).to have_text("Location can't be blank")
        expect(page).to have_text("Employment type can't be blank")
        expect(page).to have_text('Employment type not a valid employment type')
        expect(page).to have_text("Location type can't be blank")
        expect(page).to have_text("Location type not a valid location type")
        expect(page).to have_text("End date must be present if you are not currently working in this company")
      end

      it "should open the work experience form
        and save to db if all the validations passed" do
        expect(page).to have_text('Work Experiences')
        find('a[data-controller="bs-modal-form"] i.bi.bi-plus').click
        expect(page).to have_text('Add new work experience')
        
        fill_in "work_experience_job_title",	with: "Senior RoR developer" 
        fill_in "work_experience_company",	with: "Pig's Head" 
        select 'Full-time', from: 'work_experience_employment_type'
        fill_in "work_experience_location",	with: "Toronto, Canada" 
        select 'On-site', from: 'work_experience_location_type'
        fill_in "work_experience_start_date",	with: '01/01/2018' 
        fill_in "work_experience_end_date",	with: '01/03/2020' 
        fill_in "work_experience_description",	with: "I worked here for two years as a full stack Ruby on Rails developer"

        click_button('Save Changes')
        visit("/member/#{@user.id}")
        expect(page).to have_text('Senior RoR developer')
        expect(page).to have_text("Pig's Head (Full-time)")
        expect(page).to have_text("Toronto, Canada (On-site)")
        expect(page).to have_text("Jan 2018 - Mar 2020 (2 years 2 months)")
      end
    end
  end
end
