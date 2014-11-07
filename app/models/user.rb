class User < ActiveRecord::Base
  validates_presence_of :first_name,
                        :last_name,
                        :email,
                        :password_confirmation,
                        :message => "can't be blank"
  validates :email, uniqueness: true
  has_secure_password
end
