module ForumsHelper
	def topics_count(forum)
		forum.topics.count
	end

	def posts_count(forum)
		forum.posts.count
	end

	def last_post(forum)
		forum.posts.last
	end
end
