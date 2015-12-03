require "time"

class DbCommentProvider
  # Creates a comment in the database
  def create(user_id, message, video_id, parent_id)
    Comment.create(:text => message, :user_id => user_id, :date => Time.now, :videoid => video_id, :comment_id => parent_id)
  end

  # Retrieves comments from the database for a specified video id
  def get_comments(video_id)
    Comment.all(:videoid => video_id, :order => [ :date.desc ], :comment_id => nil)
  end
end
