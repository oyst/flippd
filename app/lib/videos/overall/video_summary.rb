class OverallVideoSummary
  def initialize(module_provider, video_view_provider)
    @module_provider = module_provider
    @video_view_provider = video_view_provider
  end

  def get_views_per_video()
    videos = @module_provider.get_all_videos
    start_date = @module_provider.get_start_date
    end_date = @module_provider.get_end_date
    views_per_video = []
    videos.each do |video|
      views = @video_view_provider.get_views_by_video(video['slug'], start_date, end_date)
      video['views'] = views
      views_per_video.push(video)
    end
    views_per_video
  end
end
