require 'rails_helper'

describe Task do
  skip #*************************************************************

  it 'validate a task cannot be created with a date in the past' do
    task = Task.new(description: "test description",
                    due_date: Date.today - 2.days)
    task.valid?
    expect(task.errors[:due_date].present?).to eq(true)
  end

  it 'validate a task cannot be created with a date in the past' do
    travel_to 1.day.ago do
      task = Task.new(description: "test description",
                      due_date: Date.today)
      expect(task.valid?).to be(true)
      task.save
      expect(task.valid?).to be(true)

    end
# return to the present


  end
end
