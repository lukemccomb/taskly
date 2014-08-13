require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do
  before (:each) do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
  end

  scenario 'User can view task lists' do
    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")
  end

  scenario 'User can create task lists' do
    click_on "+ Add Task List"
    fill_in "Name", with: "Random"
    click_on "Create Task List"
    expect(page).to have_content("Task List was created successfully!")
    expect(page).to have_content("Random")
  end

  scenario 'User sees error message when invalid task list title' do
    click_on "+ Add Task List"
    fill_in "Name", with: "Random"
    click_on "Create Task List"
    expect(page).to have_content("Task List was created successfully!")
    expect(page).to have_content("Random")
    click_on "+ Add Task List"
    click_on "Create Task List"
    expect(page).to have_content("Your task list could not be created")
  end

  scenario 'User can edit Task List names' do
    first('.task-list').click_on("Edit")
    expect(page).to have_field("Name", with: "Household Chores")
    fill_in "Name", with: "Groovyness"
    click_on "Update Task List"
    expect(page).to have_content("Task List was updated successfully!")
    expect(page).to have_content("Groovyness")
  end

  scenario 'User can add a task' do
    first('.task-list').click_on("+ Add Task")
    expect(page).to have_content("Add a task")
    fill_in "Name", with: "Random task"
    # fill in date
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Random task") # add due date expectation
  end

  scenario 'User can view individual tasks list pages with related tasks' do
    first('.task-list').click_on("+ Add Task")
    fill_in "Name", with: "Random task"
    click_on "Create Task"
    click_on "Household Chores"
    expect(page).to have_content("Random task")
    expect(page).to_not have_content("Work List")
  end

end