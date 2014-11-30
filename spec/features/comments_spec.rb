require "rails_helper"

feature "Comments" do
  scenario "logged in user can add a comment to a task" do
    # signup and signin a user
    visit '/'
    click_on "Sign Up"
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    # create a project
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    # create task
    click_on "0 Tasks"
    click_on "New Task"
    fill_in "Description", with: "TestTask"
    fill_in "Due date", with: "20/10/2015"
    click_on "Create Task"
    click_on "TestTask"
    expect(page).to have_selector('textarea')
    fill_in "comment[content]", with: "TestComment"
    expect(page).to have_content("TestComment")
    expect(page).to have_content("testfirst testlast")
  end

  scenario "non-logged in user cannot add a comment to a task" do
    # create a project
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    # create task
    click_on "0 Tasks"
    click_on "New Task"
    fill_in "Description", with: "TestTask"
    fill_in "Due date", with: "20/10/2015"
    click_on "Create Task"
    click_on "TestTask"
    expect(page).to have_no_selector('textarea')
  end

  

  def sign_up_with(firstname, lastname, email, password, passwordconf)
    fill_in "First name", with: firstname
    fill_in "Last name", with: lastname
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: passwordconf
    within(".well") do
      click_on("Sign up")
    end
  end
end
