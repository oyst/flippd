require "time"

class CommentProvider
  # Creates a comment in the database
  # Do we need the nil check
  def self.create(user_id, message, video_id, parent_id)
    Comment.create(:text => message, :user_id => user_id, :date => Time.now, :videoid => video_id, :comment_id => parent_id)
  end

  # Retrieves comments from the database for a specified video id
  # Needs to get top level comments with their replies or take a parent id to get chidren
  def self.get_comments(video_id, start, max, parent_id)
    allcomments = Comment.all(:videoid => video_id, :order => [ :date.desc ], :comment_id => nil)
    allcomments[ start, max ]
  end

  # Updates a comment in the database
  def update(comment_id, message)
    Comment.update(:message => message, :edited => true)
  end

  # Deletes a comment from the database
  def delete(comment_id)
    Comment.update(:deleted => true)
  end

  # Returns the number of replies a comment has
  def count(parent_id)
    return Comment.all(:parent_id.eql => @thread_id).count
  end
end
