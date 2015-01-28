require 'rails_helper'

feature "projects" do

  scenario "users can make new project" do
    user = create_user(
      first_name: "TestFirst",
      last_name: "TestLast",
      email: "test@mail.com",
      password: 'test',
      admin: false)
    sign_in(user)
    visit projects_path
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    # user can view show page
    expect(page).to have_content("TestProject")
    within(".breadcrumb") do
      click_on "TestProject"
    end
    click_on "Edit"
    fill_in "Name", with: "TestProject2"
    click_on "Update Project"
    expect(page).to have_content("TestProject2")
    # click_on "Delete"
    # expect(page).to have_content("Project was sucessfully deleted")
  end

  scenario "users cannot make new project without name" do
    user = create_user(
    first_name: "TestFirst",
    last_name: "TestLast",
    email: "test@mail.com",
    password: 'test',
    admin: false)
    sign_in(user)
    visit projects_path
    click_on "Create Project"
    click_on "Create Project"
    expect(page).to have_content("Name can't be blank")
  end

  scenario "users cannot edit a project without name" do
    user = create_user(
    first_name: "TestFirst",
    last_name: "TestLast",
    email: "test@mail.com",
    password: 'test',
    admin: false)
    sign_in(user)
    visit projects_path
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    # user can view show page
    within(".breadcrumb") do
      click_on "TestProject"
    end
    click_on "Edit"
    fill_in "Name", with: ""
    click_on "Update Project"
    expect(page).to have_content("Name can't be blank")
  end

  scenario "deleting a project should delete tasks and comments also" do
    user = create_user(
      first_name: "TestFirst",
      last_name: "TestLast",
      email: "test@mail.com",
      password: 'test',
      admin: true)
    project = create_project(name: "TestProject")
    membership = create_membership(
      user_id: user.id,
      project_id: project.id,
      role: "Member")
    task = create_task(
      project_id: project.id,
      description: "Test task",
      due_date: '20/10/2100')
    comment = create_comment(
      user_id: user.id,
      task_id: task.id,
      content: "Test comment")
    visit projects_path
    click_on "About"
    project_count = Project.count
    task_count = Task.count
    comment_count = Comment.count
    click_on "TestProject"
    expect(page).to have_content("Deleting this project will also delete 0 Memberships, 1 Task and associated comments.")
    click_on "Delete"
    # check counts
    click_on "About"
    expect(page).to have_content("0 Projects, 0 Tasks, 0 Project Members, 1 User, 0 Comments")
  end

end
