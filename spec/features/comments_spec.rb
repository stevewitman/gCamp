require "rails_helper"

feature "Comments" do

  scenario "logged in user can add a comment to a task" do
    user = create_user(
      first_name: "TestFirst",
      last_name: "TestLast",
      email: "testmail.com",
      password: 'test',
      admin: false)
    project = create_project(name: "TestProject")
    membership = create_membership(
      user_id: user.id,
      project_id: project.id,
      role: "Member")
    task = create_task(
      project_id: project.id,
      description: "Test task",
      due_date: '20/10/2100')
    sign_in(user)
    visit project_task_path(project, task)
    fill_in "comment[content]", with: "Test comment"
    click_on "Add Comment"
    visit project_task_path(project, task)
    expect(page).to have_content("Test comment")
    expect(page).to have_content("TestFirst TestLast")
    # click_on "Tasks"
    # check badge count
    # click_on "Tasks"
    # within(".badge") do
    #   expect(page).to have_content('Complete')
    # end
  end

  scenario "non-logged in user cannot add a comment to a task" do
    project = create_project(name: "TestProject")
    task = create_task(
      project_id: project.id,
      description: "Test task",
      due_date: '20/10/2100')
    visit project_task_path(project, task)
    expect(page).to have_content("You must be logged in to access that action")
    expect(page).to have_content("Sign into gCamp")
  end

  scenario "deleting a user should replace users name name with (deleted user)" do
    user_1 = create_user(
      first_name: "TestFirst_1",
      last_name: "TestLast_1",
      email: "testmail.com",
      password: 'test',
      admin: false)
    user_2 = create_user(
      first_name: "TestFirst_2",
      last_name: "TestLast_2",
      email: "test_2mail.com",
      password: 'test',
      admin: false)
    project = create_project(name: "TestProject")
    membership = create_membership(
      user_id: user_1.id,
      project_id: project.id,
      role: "Member")
    membership = create_membership(
      user_id: user_2.id,
      project_id: project.id,
      role: "Member")
    task = create_task(
      project_id: project.id,
      description: "Test task",
      due_date: '20/10/2100')
    sign_in(user_1)
    visit project_task_path(project, task)
    fill_in "comment[content]", with: "Test comment"
    click_on "Add Comment"
    click_on "Tasks"
    visit project_task_path(project, task)
    expect(page).to have_content("Test comment")
    expect(page).to have_content("TestFirst_1 TestLast_1")
    # delete user
    click_on "Users"
    within("table") do
      click_on "TestFirst_1 TestLast_1"
    end
    click_on "Edit"
    click_on "Delete"
    # check for "(deleted user)"
    sign_in(user_2)
    visit project_task_path(project, task)
    expect(page).to have_content("(deleted user)")
  end



end
