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
    expect(page).to have_content("testfirst testlast was successfully added to TestProject")
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

  scenario "users can change a member's role" do
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
    user = User.order(:id).last
    # create a project
    click_on "Projects"
    click_on "Create Project"
    expect(page).to have_content("Create project")
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    # user can view show page
    click_on "0 Members"
    select "testfirst testlast", from: "membership_user_id"
    click_on "Add New Member"
    expect(page).to have_content("Members")
    expect(page).to have_content("testfirst testlast was successfully added to TestProject")
    # user can change members role
    element_id = "select_#{user.id}"
    select "Owner", from: "select_#{user.id}"
    click_on "Update"
    expect(page).to have_content("Role for testfirst testlast was successfully updated")
    # user can delete a membership
    click_on "delete_#{user.id}"
    expect(page).to have_content("testfirst testlast was successfully removed from TestProject")

  end




end
