require 'rails_helper'

describe Task do
  it 'validate a task cannot be created with a date in the past' do
    task = Task.new(description: "test description",
                    due_date: Date.today - 2.days)
    task.valid?
    expect(task.errors[:due_date].present?).to eq(true)

# need to test that task can be edited with due_date in the past

  end
end
