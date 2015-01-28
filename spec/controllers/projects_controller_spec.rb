require 'rails_helper'

describe ProjectsController do

  describe "#create" do

    it "allows owners to update" do
      user = create_user( first_name: "TestFirst", last_name: "TestLast", email: "test@mail.com", password: 'test', admin: false)
      session[:user_id] = user.id

      post :create, project: {name: "Foobar Baz"}

      project = assigns(:project)
      expect(response).to redirect_to(project_tasks_path(project))
    end

  end

  describe "#update" do

    it "does not allow non-owners to update" do
      user = create_user( first_name: "TestFirst", last_name: "TestLast", email: "test@mail.com", password: 'test', admin: false)
      project = create_project(name: "TestProject")
      membership = create_membership( user_id: user.id, project_id: project.id, role: "Member")
      session[:user_id] = user.id

      # can't do in capybara
      patch :update, id: project.id

      expect(response.status).to eq(404)
    end

    it "allows owners to update" do
      user = create_user( first_name: "TestFirst", last_name: "TestLast", email: "test@mail.com", password: 'test', admin: false)
      project = create_project(name: "TestProject")
      membership = create_membership( user_id: user.id, project_id: project.id, role: "Owner")
      session[:user_id] = user.id

      patch :update, id: project.id, project: {name: "Foobar Baz"}

      expect(response).to redirect_to(project_path(project))

      # reload goes back to the database and gets the latest data
      expect(project.reload.name).to eq("Foobar Baz")
    end

  end

  describe "#edit" do
    it "redirects user to the login page if not signed in" do
      # setup
      project = create_project(name: "TestProject")

      # execution - this actually makes a psuedo-request
      # simulates at GET to /projects/2 (if project.id == 2)
      get :edit, id: project.id

      # expectation
      expect(response).to redirect_to(signin_path)
    end

    it "allows owners to see the page" do
      user = create_user( first_name: "TestFirst", last_name: "TestLast", email: "test@mail.com", password: 'test', admin: false)
      project = create_project(name: "TestProject")
      membership = create_membership( user_id: user.id, project_id: project.id, role: "Owner")
      session[:user_id] = user.id

      get :edit, id: project.id

      expect(response).to be_success
    end

    it "does not allow members to see the page" do
      user = create_user( first_name: "TestFirst", last_name: "TestLast", email: "test@mail.com", password: 'test', admin: false)
      project = create_project(name: "TestProject")
      membership = create_membership( user_id: user.id, project_id: project.id, role: "Member")
      session[:user_id] = user.id

      get :edit, id: project.id

      expect(response.status).to eq(404)
    end
  end
end
