require "time"

class CommentProvider
  def initialize(forum_id, thread_id)
    @forum_id = forum_id
    @thread_id = thread_id
  end

  # Creates a comment in the database
  def create(user_id, message, parent_id)
    if (parent_id == nil)
      Comment.create({ text: message }, { user: user_id }, { date: Time.now }, { threadid: thread_id }, { forumid: forum_id })
    else
      Comment.create({ text: message }, { user: user_id }, { date: Time.now }, { threadid: thread_id }, { forumid: forum_id }, { comment: parent_id })
    end
  end

  # Retrieves comments from the database for a specified video id
  def get_comments(start, max, parent_id)
    return Comment.all(:videoid.eql => @thread_id)
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
