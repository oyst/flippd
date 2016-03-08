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

  def get_views_by_month(user, month, start_date, end_date)
    views = DataMapper.repository.adapter.select("SELECT count(*)FROM flippd.views WHERE date > ? and date < ? and user_id = ? AND MONTH(date) = ?", start_date, end_date, user.id, month)
    views.first
  end

  def get_views_by_video(video_id, start_date, end_date)
    View.count(:id, :conditions => {:videoid => video_id, :date.gt => start_date, :date.lt => end_date})
  end
end
