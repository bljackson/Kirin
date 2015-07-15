class Topic < ActiveRecord::Base
	belongs_to :forum
	belongs_to :user

	has_many :subscriptions, :dependent => :destroy
	has_many :posts, :dependent => :destroy
	accepts_nested_attributes_for :posts

	validates :title, presence: true, length: { maximum: 255 }
	validates :description, length: { maximum: 255 }
  	validates_associated :posts

	def close!
		update_column(:closed, true)
	end

	def open!
		update_column(:closed, false)
	end

	def pin!
		update_column(:pinned, true)
	end

	def unpin!
		update_column(:pinned, false)
	end

	def status?
		closed? || pinned?
	end

	def status
		if closed? && pinned?
			'closed pinned'
		elsif closed?
			'closed'
		elsif pinned?
			'pinned'
		end
	end
end
