class User < ActiveRecord::Base
  validates :first_name,
            :last_name,
            :email, presence: true
  validates :email, :uniqueness => {:case_sensitive => false}
  has_secure_password
  has_many :memberships, dependent: :destroy
  has_many :comments, dependent: :nullify

  def full_name
    "#{first_name} #{last_name}"
  end

end
