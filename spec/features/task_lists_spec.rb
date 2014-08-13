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
    select '2014', :from => 'task_date_1i'
    select 'August', :from => 'task_date_2i'
    select '14', :from => 'task_date_3i'
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Random task (1 day)")
  end

  scenario 'User can view individual tasks list pages with related tasks' do
    first('.task-list').click_on("+ Add Task")
    fill_in "Name", with: "Random task"
    click_on "Create Task"
    click_on "Household Chores"
    expect(page).to have_content("Random task")
    expect(page).to_not have_content("Work List")
  end

  scenario "User can complete tasks and view completed tasks" do
    first('.task-list').click_on("+ Add Task")
    expect(page).to have_content("Add a task")
    fill_in "Name", with: "Random task"
    select '2014', :from => 'task_date_1i'
    select 'August', :from => 'task_date_2i'
    select '14', :from => 'task_date_3i'
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Random task (1 day)")
    first('.task').click_on("Complete")
    expect(page).to have_content("Task was completed")
    expect(page).to_not have_content("Random Task")
    first('.task-list').click_on("Completed")
    expect(page).to have_content("Completed Tasks")
    expect(page).to have_content("Random task (1 day)")
  end

  scenario "tasks appear in chronological order" do
    first('.task-list').click_on("+ Add Task")
    fill_in "Name", with: "Random task"
    select '2014', :from => 'task_date_1i'
    select 'August', :from => 'task_date_2i'
    select '14', :from => 'task_date_3i'
    click_on "Create Task"
    first('.task-list').click_on("+ Add Task")
    fill_in "Name", with: "Random task"
    select '2014', :from => 'task_date_1i'
    select 'August', :from => 'task_date_2i'
    select '15', :from => 'task_date_3i'
    click_on "Create Task"
    expect(page).to have_content("Random task (1 day) Random task (2 days)")
  end

  scenario "user can delete a task list and related tasks are deleted" do
    first('.task-list').click_on("Delete")
    expect(page).to_not have_content("Household Chores")
  end

  scenario "task lists with no tasks show friendly message" do
    expect(page).to have_content("Nothing to see here!")
  end

end