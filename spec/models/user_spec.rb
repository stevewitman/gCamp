require 'rails_helper'

describe User do
  it "validates the uniqueness of the email (case insensitive)" do

    User.create!(first_name: "testfirst",
                last_name: "testlast",
                email: "test@mail.com",
                password: "test",
                password_confirmation: "test")
    user2 = User.new(
                first_name: "testfirst2",
                last_name: "testlast2",
                email: "TEST@mail.com",
                password: "test",
                password_confirmation: "test")
    # expect(user2.valid?).to be(false)
    user2.valid?
    expect(user2.errors[:email.present?).to eq(true)

    user2.email = "test2@mail.com"
    expect(user2.valid?).to be(true)
  end
end
