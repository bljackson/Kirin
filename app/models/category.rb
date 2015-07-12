class Category < ActiveRecord::Base
	has_many :forums, as: :parent

	validates :name, presence: true,
					 length: { maximum: 255 }
	validates :position, numericality: { only_integer: true }
	
    scope :by_position, -> { order(:position) }
end
