require 'rails_helper'

describe User do
  it "validates the uniqueness of the email (case insensitive)" do

    User.create!(first_name: "testfirst",
                last_name: "testlast",
                email: "test@mail.com",
                password: "test",
                password_confirmation: "test")
    task = Task.new(due_date: "1/1/1900")
    task.valid?
    expect(task.errors[:due_date].present?).to eq(true)
  end
end
