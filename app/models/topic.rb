class Topic < ActiveRecord::Base
	belongs_to :forum
	belongs_to :user

	has_many :subscriptions, :dependent => :destroy
	has_many :posts, :dependent => :destroy, { order: 'posts.created_at ASC'}

	validates :subject, presence: true, length: { maximum: 255 }
	validates :user, presence: true

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
end
