class Project < ActiveRecord::Base

  validates_presence_of :name,
                        :message => "can't be blank"

end
