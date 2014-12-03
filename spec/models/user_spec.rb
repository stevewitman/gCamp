require 'rails_helper'

describe User do
  it "validates the uniqueness of the email (case insensitive)" do

    User.create!(first_name: "testfirst",
                last_name: "testlast",
                email: "test@mail.com",
                password: "test",
                password_confirmation: "test")
    # create another user with same email but w/some caps
    user2 = User.new(
                first_name: "testfirst2",
                last_name: "testlast2",
                email: "TEST@mail.com",
                password: "test",
                password_confirmation: "test")
    user2.valid?
    # this should give "has already been taken"
    expect(user2.errors[:email]).to eq(["has already been taken"])
    # show that we can create that same user with a unique email
    user2.email = "test2@mail.com"
    expect(user2.valid?).to be(true)
  end
end
