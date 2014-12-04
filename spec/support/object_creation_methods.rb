module ObjectCreationMethods

  def new_project(overrides = {})
    defaults = { description: Faker::Company.name }
    Project.new(defaults.merge(overrides))
  end

  def create_project(overrides = {})
    new_project(overrides).tap(&:save!)
  end

  def create_user(overrides = {})
    defaults = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email_address: Faker::Internet.email,
      password: 'password',
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
      description: Faker::Lorem.sentence,
      due_date: '01/01/2999',
    }
    Task.new(defaults.merge(overrides))
  end


  def create_task(overrides = {})
    defaults = {
      project: create_project,
      description: Faker::Lorem.sentence,
      due_date: '01/01/2999',
    }
    Task.create!(defaults.merge(overrides))
  end

  def create_comment(overrides = {})
    defaults = {
      task: create_task,
      copy: Faker::Lorem.sentence,
    }
    Comment.create!(defaults.merge(overrides))
  end

  def create_session
    create_user
    session[:user_id] = create_user.id
  end

end
