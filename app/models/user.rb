class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :name, presence: true, 
					 length: { maximum: 50 },
					 uniqueness: { case_sensitive: false }
	validates :terms_of_service, acceptance: true

  # Setup accessible (or protected) attributes
  attr_accessor :name, :email, :password, :password_confirmation, :terms_of_service
end
