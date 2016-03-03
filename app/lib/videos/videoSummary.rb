class VideoSummary
  def initialize(moduleData, videoViewProvider)
    @moduleData = moduleData
    @videoProvider = videoViewProvider
  end
  def get_videos_by_month(user)
    views = @videoProvider.get_views_by_month(user, @moduleData['startDate'], @moduleData['endDate'])
    start_date = Time.parse(@moduleData['startDate'])
    end_date = Time.parse(@moduleData['endDate'])
    @formatted_views = []
    views.each do |view|
      @formatted_views.push(view.total_views)
    end
    return @formatted_views
  end
end
