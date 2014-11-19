require 'rails_helper'

feature "Users" do
  scenario "users can create a user" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("User was successfully created")
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
    expect(page).to have_content("testfirst testlast")
    expect(page).to have_content("test@mail.com")
    expect(page).to have_no_content("Sign Out")
  end

  scenario "users can click on name to go to show page" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("testfirst testlast")
    click_on "testfirst testlast"
    expect(page).to have_content("First Name")
    expect(page).to have_content("testfirst")
    expect(page).to have_content("Last Name")
    expect(page).to have_content("testlast")
  end

  scenario "users can click edit on show page to go to edit page" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("testfirst testlast")
    click_on "testfirst testlast"
    expect(page).to have_content("First Name")
    click_on "Edit"
    expect(page).to have_content("Edit user")
  end

  scenario "users can edit users" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("testfirst testlast")
    click_on "testfirst testlast"
    expect(page).to have_content("First Name")
    click_on "Edit"
    expect(page).to have_content("Edit user")
    fill_in "First name", with: "testfirst2"
    fill_in "Last name", with: "testlast2"
    fill_in "Email", with: "test2@mail.com"
    fill_in "Password", with: "test2"
    fill_in "Password confirmation", with: "test2"
    click_on "Update User"
    expect(page).to have_content("testfirst2")
  end

  scenario "users can delete users" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("testfirst testlast")
    click_on "testfirst testlast"
    expect(page).to have_content("First Name")
    click_on "Edit"
    expect(page).to have_content("Edit user")
    click_on "Destroy"
    expect(page).to have_content("User was successfully removed.")
  end

  def sign_up_with(firstname, lastname, email, password, passwordconf)
    fill_in "First name", with: firstname
    fill_in "Last name", with: lastname
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: passwordconf
    click_on("Create User")
  end

  scenario "users can change users passwords" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("testfirst testlast")
    click_on "testfirst testlast"
    expect(page).to have_content("First Name")
    click_on "Edit"
    expect(page).to have_content("Edit user")
    fill_in "Password", with: "test2"
    fill_in "Password confirmation", with: "test2"
    click_on "Update User"
    click_on "Sign In"
    fill_in "Email", with: 'test@mail.com'
    fill_in "Password", with: 'test2'
    within(".well") do
      click_on "Sign In"
    end
    expect(page).to have_content("testfirst testlast")
  end

  scenario "users cannot create a user without a first name" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    fill_in "First name", with: ""
    fill_in "Last name", with: "testlast"
    fill_in "Email", with: "test@mail.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on("Create User")
    expect(page).to have_content("First name can't be blank")
  end

  scenario "users cannot edit a user without a first name" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("testfirst testlast")
    click_on "testfirst testlast"
    expect(page).to have_content("First Name")
    click_on "Edit"
    expect(page).to have_content("Edit user")
    fill_in "First name", with: ""
    fill_in "Last name", with: "testlast2"
    fill_in "Email", with: "test2@mail.com"
    fill_in "Password", with: "test2"
    fill_in "Password confirmation", with: "test2"
    click_on "Update User"
    expect(page).to have_content("First name can't be blank")
  end

  scenario "users cannot create a user without a last name" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    fill_in "First name", with: "testfirst"
    fill_in "Last name", with: ""
    fill_in "Email", with: "test@mail.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on("Create User")
    expect(page).to have_content("Last name can't be blank")
  end

  scenario "users cannot edit a user without a last name" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("testfirst testlast")
    click_on "testfirst testlast"
    expect(page).to have_content("First Name")
    click_on "Edit"
    expect(page).to have_content("Edit user")
    fill_in "First name", with: "testlast2"
    fill_in "Last name", with: ""
    fill_in "Email", with: "test2@mail.com"
    fill_in "Password", with: "test2"
    fill_in "Password confirmation", with: "test2"
    click_on "Update User"
    expect(page).to have_content("Last name can't be blank")
  end

  scenario "users cannot create a user without an email" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    fill_in "First name", with: "testfirst"
    fill_in "Last name", with: "testlast"
    fill_in "Email", with: ""
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on("Create User")
    expect(page).to have_content("Email can't be blank")
  end

  scenario "users cannot edit a user without an email" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("testfirst testlast")
    click_on "testfirst testlast"
    expect(page).to have_content("First Name")
    click_on "Edit"
    expect(page).to have_content("Edit user")
    fill_in "First name", with: "testlast2"
    fill_in "Last name", with: "testlast2"
    fill_in "Email", with: ""
    fill_in "Password", with: "test2"
    fill_in "Password confirmation", with: "test2"
    click_on "Update User"
    expect(page).to have_content("Email can't be blank")
  end

  scenario "users must use a unique email to create a user" do
    visit '/'
    click_on "Users"
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    fill_in "First name", with: "testfirst"
    fill_in "Last name", with: "testlast"
    fill_in "Email", with: "test@mail.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on("Create User")
    click_on "Create User"
    expect(page).to have_content("Create a new user")
    fill_in "First name", with: "testfirst2"
    fill_in "Last name", with: "testlast2"
    fill_in "Email", with: "test@mail.com"
    fill_in "Password", with: "test2"
    fill_in "Password confirmation", with: "test2"
    click_on("Create User")
    expect(page).to have_content("Email has already been taken")
  end
end
