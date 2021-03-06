require 'rails_helper'

feature "Tasks" do
  scenario "users can make new task" do
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    click_on "0 Tasks"
    click_on "New Task"
    expect(page).to have_content("Create a new task")
    fill_in "Description", with: "TestDescription"
    fill_in "Due date", with: "20/10/2015"
    click_on "Create Task"
    expect(page).to have_content("Task was successfully created.")
    expect(page).to have_content("TestDescription")
    expect(page).to have_content("false")
    expect(page).to have_content("10/20/2015")
  end

  scenario "users can edit tasks" do
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    click_on "0 Tasks"
    click_on "New Task"
    expect(page).to have_content("Create a new task")
    fill_in "Description", with: "TestDescription"
    fill_in "Due date", with: "20/10/2015"
    click_on "Create Task"
    click_on "Edit"
    expect(page).to have_content("Edit task")
    fill_in "Description", with: "TestDescription2"
    fill_in "Due date", with: "20/11/2015"
    check('Complete')
    click_on "Update Task"
    expect(page).to have_content("Task was successfully updated.")
    click_on "All"
    expect(page).to have_content("TestDescription2")
    expect(page).to have_content("true")
    expect(page).to have_content("11/20/2015")
  end

  scenario "users can sort tasks by all or incomplete" do
    visit '/'
    # Create first task
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    click_on "0 Tasks"
    click_on "New Task"
    fill_in "Description", with: "TestDescription1"
    fill_in "Due date", with: "20/10/2015"
    click_on "Create Task"
    # Set first task to complete
    click_on "Edit"
    check('Complete')
    click_on "Update Task"
    # Create second task
    click_on "New Task"
    fill_in "Description", with: "TestDescription2"
    fill_in "Due date", with: "21/11/2015"
    click_on "Create Task"
    # Only incomplete tasks showing
    expect(page).to have_content("TestDescription2")
    expect(page).to have_no_content("TestDescription1")
    click_on "All"
    # All tasks showing
    expect(page).to have_content("TestDescription2")
    expect(page).to have_content("TestDescription1")
  end

  scenario "users can show task" do
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    click_on "0 Tasks"
    click_on "New Task"
    expect(page).to have_content("Create a new task")
    fill_in "Description", with: "TestDescription"
    fill_in "Due date", with: "20/10/2015"
    click_on "Create Task"
    click_on "TestDescription"
    expect(page).to have_content("TestDescription")
    expect(page).to have_content("Completed:  false")
    expect(page).to have_content("Due Date:  10/20/2015")
  end

  scenario "users can delete tasks" do
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    click_on "0 Tasks"
    click_on "New Task"
    expect(page).to have_content("Create a new task")
    fill_in "Description", with: "TestDescription"
    fill_in "Due date", with: "20/10/2015"
    click_on "Create Task"
    task = Task.order(:id).last
    expect(page).to have_content("TestDescription")
    click_on "delete_#{task.id}"
    expect(page).to have_no_content("TestDescription")
  end

  scenario "users must enter a description when creating a new task" do
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    click_on "0 Tasks"
    click_on "New Task"
    expect(page).to have_content("Create a new task")
    fill_in "Description", with: ""
    fill_in "Due date", with: "20/10/2015"
    click_on "Create Task"
    expect(page).to have_content("Description can't be blank")
  end

  scenario "users must enter a description when editing a task" do
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    click_on "0 Tasks"
    click_on "New Task"
    expect(page).to have_content("Create a new task")
    fill_in "Description", with: "TestDescription"
    fill_in "Due date", with: "20/10/2015"
    click_on "Create Task"
    click_on "Edit"
    expect(page).to have_content("Edit task")
    fill_in "Description", with: ""
    fill_in "Due date", with: "20/11/2015"
    check('Complete')
    click_on "Update Task"
    expect(page).to have_content("Description can't be blank")
  end

  scenario "users cannot make new task with due date in the past" do
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    click_on "0 Tasks"
    click_on "New Task"
    expect(page).to have_content("Create a new task")
    fill_in "Description", with: "TestDescription"
    fill_in "Due date", with: "20/10/2013"
    click_on "Create Task"
    expect(page).to have_content("Due date can't be in the past")
  end

  scenario "users can edit tasks with a due date that is in the past" do
    visit '/'
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "TestProject"
    click_on "Create Project"
    click_on "0 Tasks"
    click_on "New Task"
    expect(page).to have_content("Create a new task")
    fill_in "Description", with: "TestDescription"
    fill_in "Due date", with: "20/10/2015"
    click_on "Create Task"
    click_on "Edit"
    expect(page).to have_content("Edit task")
    fill_in "Description", with: "TestTwoDescription"
    fill_in "Due date", with: "20/11/2013"
    check('Complete')
    click_on "Update Task"
    expect(page).to have_content("Task was successfully updated.")
  end

  scenario "deleting a task should delete comment(s) also" do
    user = create_user(
    first_name: "TestFirst",
    last_name: "TestLast",
    email: "test@mail.com",
    password: 'test',
    admin: false)
    project = Project.create!(name: "TestProject")
    membership = Membership.create!(
    user_id: user.id,
    project_id: project.id,
    role: "Member")
    task = Task.create!(
    project_id: project.id,
    description: "Test task",
    due_date: '20/10/2100')
    sign_in(user)
    visit project_task_path(project, task)
    fill_in "comment[content]", with: "Test comment"
    click_on "Add Comment"
    click_on "About"
    expect(page).to have_content("1 Project, 1 Task, 1 Project Member, 1 User, 1 Comment")
    visit project_task_path(project, task)
    expect(page).to have_content("Test comment")
    expect(page).to have_content("TestFirst TestLast")
    # delete task
    visit project_tasks_path(project)
    task_last = Task.order(:id).last
    click_on "delete_#{task_last.id}"
    # check counts
    click_on "About"
    expect(page).to have_content("1 Project, 0 Tasks, 0 Project Members, 1 User, 0 Comments")
  end
  
end
