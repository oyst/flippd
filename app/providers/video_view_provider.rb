class VideoViewProvider
  def add_view(user, video_id)
    View.create(:videoid => video_id, :user => user, :date => Time.now)
  end

  def get_view(user, video_id)
    View.first(:user => user, :videoid => video_id)
  end

  def remove_view(user, video_id)
    view = get_view(user, video_id)
    view.destroy
  end
end
