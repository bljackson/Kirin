class Post < ActiveRecord::Base
	belongs_to :topic
	belongs_to :user

	has_many :replies, :dependent => :nullify

	validates :content, presence: true
end
