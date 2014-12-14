require 'rails_helper'

feature "projects" do

  before(:each) do
    @user = create_user
    @project = create_project
    signin
  end

  def signin
    visit root_path
    click_on 'Sign In'
    visit '/sign-in'
    fill_in 'Email', with: @user.email_address
    fill_in 'Password', with: @user.password
    click_on 'Log In'
  end

  scenario "users can make new project" do
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    expect(page).to have_content("Create project")
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    # user can view show page
    expect(page).to have_content("TestProject")
    click_on "Edit"
    fill_in "Name", with: "TestProject2"
    click_on "Update Project"
    expect(page).to have_content("TestProject2")
    click_on "Delete"
    expect(page).to have_content("Project was sucessfully deleted")
  end

  scenario "users cannot make new project without name" do
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    expect(page).to have_content("Create project")
    fill_in "Name", with: ""
    click_on "Create Project"
    expect(page).to have_content("Name can't be blank")
  end

  scenario "users cannot edit a project without name" do
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    expect(page).to have_content("Create project")
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    # user can view show page
    expect(page).to have_content("TestProject")
    click_on "Edit"
    fill_in "Name", with: ""
    click_on "Update Project"
    expect(page).to have_content("Name can't be blank")
  end

  scenario "deleting a project should delete tasks and comments also" do
    visit '/'
    sign_up_with 'testfirst', 'testlast', 'testmail.com', 'test', 'test'
    create_project 'TestProject'
    create_task 'TestTask'
    click_on "TestTask"
    fill_in "comment[content]", with: "TestComment"
    click_on "Add Comment"
    # delete task
    click_on "TestProject"
    expect(page).to have_content("Deleting this project will also delete 0 Memberships, 1 Task and associated comments.")
    click_on "Delete"
    # check counts
    click_on "About"
    expect(page).to have_content("0 Projects, 0 Tasks, 0 Project Members, 1 User, 0 Comments")
  end
  
end
