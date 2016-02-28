class VideoViewProvider
  def add_view(user, video_id)
    View.create(:videoid => video_id, :user => user, :date => Time.now)
  end

  def has_viewed(user, video_id)
    #will return whether the user has viewed the video
  end
end
