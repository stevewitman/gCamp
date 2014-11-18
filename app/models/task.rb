class Task < ActiveRecord::Base
  validates :description, :due_date, presence: true
  validate :due_date_in_past, :on => :create

  belongs_to :project

  def due_date_in_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

end
