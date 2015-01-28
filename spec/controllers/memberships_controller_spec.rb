require 'rails_helper'

describe MembershipsController do

  describe "#index" do
    it "redirects user to the login page if not signed in" do
      user = create_user( first_name: "TestFirst", last_name: "TestLast", email: "test@mail.com", password: 'test', admin: false)
      project = create_project(name: "TestProject")
      membership = create_membership( user_id: user.id, project_id: project.id, role: "Owner")
      get :index, {project_id: project.id, user_id: user.id}
      expect(response).to redirect_to(signin_path)
    end

    it "allows members to view memberships" do
      user = create_user( first_name: "TestFirst", last_name: "TestLast", email: "test@mail.com", password: 'test', admin: false)
      project = create_project(name: "TestProject")
      membership = create_membership( user_id: user.id, project_id: project.id, role: "Member")
      session[:user_id] = user.id
      get :index, {project_id: project.id, user_id: user.id}
      expect(response).to be_success
    end

    it "allows owners to view memberships" do
      user = create_user( first_name: "TestFirst", last_name: "TestLast", email: "test@mail.com", password: 'test', admin: false)
      project = create_project(name: "TestProject")
      membership = create_membership( user_id: user.id, project_id: project.id, role: "Owner")
      session[:user_id] = user.id
      get :index, {project_id: project.id, user_id: user.id}
      expect(response).to be_success
    end

    it "allows admin to view memberships they are not members of" do
      user = create_user( first_name: "TestFirst", last_name: "TestLast", email: "test@mail.com", password: 'test', admin: false)
      user2 = create_user( first_name: "TestFirst2", last_name: "TestLast2", email: "test2@mail.com", password: 'test', admin: true)
      project = create_project(name: "TestProject")
      membership = create_membership( user_id: user.id, project_id: project.id, role: "Member")
      session[:user_id] = user2.id
      get :index, {project_id: project.id, user_id: user.id}
      expect(response).to be_success
    end

  end

end
