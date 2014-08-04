require 'rails_helper'
require 'capybara/rails'

feature 'About' do

  scenario 'Anonymous can view about page' do

    visit signin_path
    click_on "About"
    expect(page).to have_content("About")
    expect(page).to have_content("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ac dui sit amet nunc semper gravida.")
  end

end