module ObjectCreationMethods

  def new_project(overrides = {})
    defaults = { name: "TestProject" }
    Project.new(defaults.merge(overrides))
  end

  def create_project(overrides = {})
    new_project(overrides).tap(&:save!)
  end

  def create_user(overrides = {})
    defaults = {
      first_name: "TestFirst",
      last_name: "TestLast",
      email: "test@mail.com",
      password: 'test',
      admin: false,
    }
    User.create(defaults.merge(overrides))
  end

  def create_membership(overrides = {})
    defaults = {
      user: create_user,
      project: create_project,
      role: 'Member',
    }
    Membership.create!(defaults.merge(overrides))
  end

  def update_membership(overrides = {})
    create_membership
  end

  def new_task(overrides = {})
    defaults = {
      project: create_project,
      description: "Test task",
      due_date: '20/10/2100',
    }
    Task.new(defaults.merge(overrides))
  end

  def create_task(overrides = {})
    defaults = {
      project: create_project,
      description: "Test task2",
      due_date: '01/01/2999',
    }
    Task.create!(defaults.merge(overrides))
  end

  def create_comment(overrides = {})
    defaults = {
      task: create_task,
      content: "Test comment",
    }
    Comment.create!(defaults.merge(overrides))
  end

  def create_session
    create_user
    session[:user_id] = create_user.id
  end


  def sign_in(user)
    visit '/sign-in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within(".well") do
      click_on("Sign In")
    end
  end

  def delete_all_records
    User.delete_all
    Project.delete_all
    Task.delete_all
    Membership.delete_all
  end

end
