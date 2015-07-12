class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  # Role/Permission relationships
  has_and_belongs_to_many :roles
  has_many :permissions, :through => :roles
  after_create :default_role

  # Sign-up validation
	validates :name, presence: true, 
					 length: { maximum: 50 },
					 uniqueness: { case_sensitive: false }
	validates :terms_of_service, acceptance: true

	attr_accessor :terms_of_service

  # create on the fly the method to handle all the
	# is_a_superuser?
	def method_missing(method_id, *args)
		if match = matches_dynamic_role_check?(method_id)
			tokenize_roles(match.captures.first).each do |check|
				return true if roles.collect{|r| r.name.downcase }.include?(check)
			end
			return false
		elsif match = matches_dynamic_perm_check?(method_id)
			tokenize_roles(match.captures.first).each do |check|	
				return true if permissions.collect{|p| p.name.downcase }.include?(check)
			end
			return false
		else
			super
		end
	end

  private

		def default_role
			if is_first_user? && !self.roles.include?(Role.find_by_name('Admin'))
	    	self.roles << Role.find_by_name('Admin')
	    elsif !self.roles.include?(Role.find_by_name('User'))
	    	self.roles << Role.find_by_name('User')
	    end
	  end

	  def is_first_user?
	  	if User.count == 1
	  		true
	  	end
	  end

	  # previous methods omitted
	  def matches_dynamic_perm_check?(method_id)
	    /^can_([a-zA-Z]\w*)\?$/.match(method_id.to_s)
	  end

		def matches_dynamic_role_check?(method_id)
		  /^is_an?_([a-zA-Z]\w*)\?$/.match(method_id.to_s)
		end

		def tokenize_roles(string_to_split)
		  string_to_split.split(/_or_/)
		end
end
