class Forum < ActiveRecord::Base
	# Can belong to Forum or Category
	belongs_to :parent, polymorphic: true,
	                    class_name: "Forum"

	has_many :subforums, as: :parent, 
	                     class_name: "Forum",
	                     foreign_key: "parent_id"
	has_many :topics
	has_many :posts, :through => :topics, :dependent => :destroy
	has_many :moderator_groups
	has_many :moderators, :through => :moderator_groups, :source => :group

	# Requires parent id, parent type, name, and numerical position to be valid
	validates :parent_id, presence: true
	validates :parent_type, presence: true
	validates :name, presence: true
	validates :position, numericality: { only_integer: true }

	default_scope { order(:position) }

end
