require 'rails_helper'

feature "Authentication" do

  scenario "users can signup" do
    visit '/'
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
    click_on "Sign Up"
    expect(page).to have_content("Sign Up for gCamp!")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("testfirst testlast")
    expect(page).to have_content("Sign Out")
    expect(page).to have_no_content("Sign In")
    expect(page).to have_no_content("Sign Up")
  end

  scenario "users cannot signup with invalid" do
    visit '/'
    click_on "Sign Up"
    expect(page).to have_content("Sign Up for gCamp!")

    # invalid case missing first name
    sign_up_with '', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("First name can't be blank")

    # invalid case missing last name
    sign_up_with 'testfirst', '', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("Last name can't be blank")

    # invalid case missing email
    sign_up_with 'testfirst', 'testlast', '', 'test', 'test'
    expect(page).to have_content("Email can't be blank")

    # invalid case missing password
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', '', 'test'
    expect(page).to have_content("Password can't be blank")

    # invalid case missing password confirmation
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', ''
    expect(page).to have_content("Password confirmation can't be blank")

    # invalid case invalid email
    # sign_up_with 'testfirst', 'testlast', 'test@mail', 'test', ''
    # expect(page).to have_content("Password confirmation can't be blank")

    # invalid case signup twice with same email
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    click_on "Sign Out"
    click_on "Sign Up"
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    expect(page).to have_content("Email has already been taken")

    # invalid case not matching passwords
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'pass'
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario "users can signin and signout" do
    visit '/'
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
    click_on "Sign Up"
    expect(page).to have_content("Sign Up for gCamp!")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    click_on "Sign Out"
    click_on "Sign In"
    fill_in "Email", with: 'test@mail.com'
    fill_in "Password", with: 'test'
    within(".well") do
      click_on "Sign In"
    end
    expect(page).to have_content("testfirst testlast")
    expect(page).to have_content("Sign Out")
    click_on "Sign Out"
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
    expect(page).to have_no_content("Sign Out")

  end

  scenario "users cannot signin with invalid" do
    visit '/'
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
    click_on "Sign Up"
    expect(page).to have_content("Sign Up for gCamp!")
    sign_up_with 'testfirst', 'testlast', 'test@mail.com', 'test', 'test'
    click_on "Sign Out"
    click_on "Sign In"

    # invalid case no email
    fill_in "Email", with: ''
    fill_in "Password", with: 'test'
      within(".well") do
      click_on "Sign In"
    end
    expect(page).to have_content("Username / password combination is invalid")

    # invalid case wrong email
    fill_in "Email", with: 'different@mail.com'
    fill_in "Password", with: 'test'
    within(".well") do
      click_on "Sign In"
    end
    expect(page).to have_content("Username / password combination is invalid")

    # invalid case no password
    fill_in "Email", with: 'test@mail.com'
    fill_in "Password", with: ''
    within(".well") do
      click_on "Sign In"
    end
    expect(page).to have_content("Username / password combination is invalid")

    # invalid case wrong email
    fill_in "Email", with: 'test@mail.com'
    fill_in "Password", with: 'wrongpass'
    within(".well") do
      click_on "Sign In"
    end
    expect(page).to have_content("Username / password combination is invalid")
  end

  def sign_up_with(firstname, lastname, email, password, passwordconf)
    fill_in "First name", with: firstname
    fill_in "Last name", with: lastname
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: passwordconf
    within(".well") do
      click_on("Sign up")
    end
  end

end
