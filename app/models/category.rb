class Category < ActiveRecord::Base
	has_many :forums

	validates :name, presence: true,
					 length: { maximum: 255 }
	validates :position, numercality: { only_integer: true }
	
    scope :by_position, -> { order(:position) }
end
