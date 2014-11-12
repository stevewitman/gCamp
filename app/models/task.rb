class Task < ActiveRecord::Base

  validates_presence_of :description,
                        :message => "can't be blank"

end
