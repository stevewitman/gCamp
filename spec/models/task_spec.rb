require 'rails_helper'

describe Task do
  include ActiveSupport::Testing::TimeHelpers
  it 'validates a task cannot be created with a date in the past' do
    task = Task.new(description: "test description",
                    due_date: Date.today - 2.days)
    task.valid?
    expect(task.errors[:due_date].present?).to eq(true)
  end

  it 'validates a task can be edited with a date in the past' do
    task = Task.new
    travel_to 1.day.ago do
      task.description = "test description"
      task.due_date = Date.today
      expect(task.valid?).to be(true)
      task.save
    end
    travel_to 0.day.ago do
      task.description = "test description2"
      task.save
      expect(task.valid?).to be(true)
    end
  end
end
