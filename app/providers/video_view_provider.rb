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

  def get_views_by_month(user, start_date, end_date)
    DataMapper.repository.adapter.select("SELECT MONTH(date) as month, count(id) as total_views FROM flippd.views WHERE date > ? and date < ? GROUP BY MONTH(date)", start_date, end_date)
  end
end
