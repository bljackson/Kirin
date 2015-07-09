class Forum < ActiveRecord::Base
	belongs_to :category

	has_many :topics
	has_many :posts, :through => :topics, :dependent => :destroy
	has_many :moderator_groups
	has_many :moderators, :through => :moderator_groups, :source => :group

	validates :category, presence: true
	validates :name, presence: true
	validates :position, numericality: { only_integer: true }

	default_scope { order(:position) }

end
