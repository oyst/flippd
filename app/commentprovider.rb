require 'data_mapper'

class CommentProvider
	
	# Creates a comment in the database
	def create(video_id, user_id, message, reply_id)		
		if (reply_id == nil)
			Comment.create({text: message}, {user: user_id}, {date: Time.now}, {videoid: video_id})
		else
			Comment.create({text: message}, {user: user_id}, {date: Time.now}, {videoid: video_id}, {comment: reply_id})
		end
	end
	
	# Retrieves comments from the database for a specified video id
	def get_comments(video_id)
		return Comment.all(:videoid.eql => video_id)
	end
	
	# Updates a comment in the database
	def update(comment_id, message)
		Comment.update(:message => message)
	end
	
	# Deletes a comment from the database
	def delete(comment_id)
		Comment.update(:deleted => true)
	end
end