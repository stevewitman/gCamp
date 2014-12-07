module ObjectCreationMethods

  def new_project(overrides = {})
    defaults = {name: "TestProject"},
    Project.new(defaults.merge(overrides))
  end

  def create_project(overrides = {})
    new_project(overrides).tap(&:save!)
  end
  
  def new_task(overrides = {})
    defaults = {
      description: "TestTask for TestProject",
      project: new_project
    }
    Task.new(defaults.merge(overrides))
  end

  def create_task(overrides = {})
    new_task(overrides).tap(&:save!)
  end

  def new_user(overrides = {})
    defaults = {
      first_name: "TestFirst",
      last_name: "TestLast",
      password: "test",
      email: "test@mail.com"
    }
    User.new(defaults.merge(overrides))
  end

  def create_user(overrides = {})
    new_user(overrides).tap(&:save!)
  end

  def new_membership(overrides = {})
    defaults = {
      user: new_user,
      project: new_project,
      role: "Member"
    }
    Membership.new(defaults.merge(overrides))
  end

  def create_membership(overrides = {})
    new_membership(overrides).tap(&:save!)
  end

  def new_comment(overrides = {})
    defaults = {
      task: new_task,
      user: new_user,
      content: "TestComment"
    }
    Comment.new(defaults.merge(overrides))
  end

  def create_comment(overrides = {})
    new_comment(overrides).tap(&:save!)
  end

end
