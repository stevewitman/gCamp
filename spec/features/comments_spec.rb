require "rails_helper"

feature "Comments" do
  scenario "logged in user can add a comment to a task" do
    visit '/'
    # signup and signin a user
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    # create a project
    create_project 'TestProject'
    # create a task
    create_task 'TestTask'
    click_on "TestTask"
    expect(page).to have_selector('textarea')
    fill_in "comment[content]", with: "TestComment"
    click_on "Add Comment"
    expect(page).to have_content("TestComment")
    expect(page).to have_content("testfirst testlast")
    # check badge count
    click_on "Tasks"
    within(".badge") do
      expect(page).to have_content('1')
    end
  end

  scenario "non-logged in user cannot add a comment to a task" do
    visit '/'
    # do not sign in
    # create a project
    create_project 'TestProject'
    # create a task
    create_task 'TestTask'
    click_on "TestTask"
    expect(page).to have_no_selector('textarea')
  end

  scenario "deleting a user should replace users name name with (deleted user)" do
    visit '/'
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    create_project 'TestProject'
    create_task 'TestTask'
    click_on "TestTask"
    fill_in "comment[content]", with: "TestComment"
    click_on "Add Comment"
    # check counts
    click_on "About"
    expect(page).to have_content("1 Project, 1 Task, 0 Project Members, 1 User, 1 Comment")
    # delete user
    click_on "Sign Out"
    click_on "Users"
    click_on "testfirst testlast"
    click_on "Edit"
    click_on "Delete"
    # check counts again
    click_on "About"
    expect(page).to have_content("1 Project, 1 Task, 0 Project Members, 0 Users, 1 Comment")
    # check for "(deleted user)"
    click_on "Projects"
    click_on "TestProject"
    click_on "1 Task"
    click_on "TestTask"
    expect(page).to have_content("(deleted user)")
  end

  scenario "deleting a task should delete comment(s) also" do
    visit '/'
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    create_project 'TestProject'
    create_task 'TestTask'
    click_on "TestTask"
    fill_in "comment[content]", with: "TestComment"
    click_on "Add Comment"
    # delete task
    click_on "Tasks"
    task = Task.order(:id).last
    click_on "delete_#{task.id}"
    # check counts
    click_on "About"
    expect(page).to have_content("1 Project, 0 Tasks, 0 Project Members, 1 User, 0 Comments")
  end

  scenario "deleting a project should delete tasks and comments also" do
    visit '/'
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
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

  def sign_up_with(firstname, lastname, email, password, passwordconf)
    click_on "Sign Up"
    fill_in "First name", with: firstname
    fill_in "Last name", with: lastname
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: passwordconf
    within(".well") do
      click_on("Sign up")
    end
  end

  def create_project(name)
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: name
    click_on "Create Project"
  end

  def create_task(description)
    click_on "0 Tasks"
    click_on "New Task"
    fill_in "Description", with: "TestTask"
    fill_in "Due date", with: "20/10/2015"
    click_on "Create Task"
  end


end
