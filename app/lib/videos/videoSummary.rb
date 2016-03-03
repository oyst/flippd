class VideoSummary
  def initialize(videoViewProvider)
    @videoProvider = videoViewProvider
  end
  def get_videos_by_month(user)
    videoViewProvider.get_views_by_month(user)

  end
end
