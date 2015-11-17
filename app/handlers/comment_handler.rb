class CommentHandler

  def self.get_by_video_id(video_id)
    return Comment.all(:video_id => video_id)
  end

  def self.add_comment(video_id, user_id, text)
    comment = Comment.create(:video_id => video_id, :user_id => user_id, :text => text, :date => Time.now())
    return comment.saved()
  end

end
