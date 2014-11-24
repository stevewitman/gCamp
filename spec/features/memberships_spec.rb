require 'rails_helper'

feature "Memeberships" do
  scenario "users can make new membership" do
    # create a user
    visit '/'
    click_on "Users"
    click_on "Create User"
    fill_in "First name", with: "testfirst"
    fill_in "Last name", with: "testlast"
    fill_in "Email", with: "test@mail.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on("Create User")
    # create a project
    click_on "Projects"
    click_on "Create Project"
    expect(page).to have_content("Create project")
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    # user can view show page
    click_on "0 Members"
    select "testfirst testlast", from: "membership_user_id"
    select "Owner", from: "membership_role"
    click_on "Add New Member"
    expect(page).to have_content("testfirst testlast was successfully created.")
  end

  scenario "users cannot make new membership without selecting a user" do
    # create a project
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    expect(page).to have_content("Create project")
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    # user can view show page
    click_on "0 Members"
    select "Owner", from: "membership_role"
    click_on "Add New Member"
    expect(page).to have_content("User can't be blank")
  end

  scenario "users cannot make new membership with a user that has already been added" do
    # create a user
    visit '/'
    click_on "Users"
    click_on "Create User"
    fill_in "First name", with: "testfirst"
    fill_in "Last name", with: "testlast"
    fill_in "Email", with: "test@mail.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on("Create User")
    # create a project
    click_on "Projects"
    click_on "Create Project"
    expect(page).to have_content("Create project")
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    # user can view show page
    click_on "0 Members"
    select "testfirst testlast", from: "membership_user_id"
    select "Owner", from: "membership_role"
    click_on "Add New Member"
    select "testfirst testlast", from: "membership_user_id"
    click_on "Add New Member"
    expect(page).to have_content("User has already been added")
  end

  scenario "users can make new membership" do
    # create a user
    visit '/'
    click_on "Users"
    click_on "Create User"
    fill_in "First name", with: "testfirst"
    fill_in "Last name", with: "testlast"
    fill_in "Email", with: "test@mail.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on("Create User")
    userid =
    # create a project
    click_on "Projects"
    click_on "Create Project"
    expect(page).to have_content("Create project")
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    # user can view show page
    click_on "0 Members"
    select "testfirst testlast", from: "membership_user_id"
    select "Owner", from: "membership_role"
    click_on "Add New Member"
    expect(page).to have_content("testfirst testlast was successfully created.")
    save_and_open_page
    select "Member", from: "1"


  end




end
