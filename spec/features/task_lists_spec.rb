require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do
  before (:each) do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")
  end

  scenario 'User can view task lists' do

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")
  end

  scenario 'User can create task lists' do
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    click_on "+ Add Task List"
    fill_in "Name", with: "Random"
    click_on "Create Task List"
    expect(page).to have_content("Task List was created successfully!")
    expect(page).to have_content("Random")
  end

  scenario 'User sees error message when invalid task list title' do
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    click_on "+ Add Task List"
    fill_in "Name", with: "Random"
    click_on "Create Task List"
    expect(page).to have_content("Task List was created successfully!")
    expect(page).to have_content("Random")
    click_on "+ Add Task List"
    click_on "Create Task List"
    expect(page).to have_content("Your task list could not be created")

  end

end