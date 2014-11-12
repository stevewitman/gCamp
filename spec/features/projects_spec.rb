require 'rails_helper'

feature "projects" do

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
    click_on "Destroy"
    expect(page).to have_content("Project was sucessfully deleted")
  end

end