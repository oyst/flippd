require 'date'

class VideoSummary
  def initialize(moduleProvider, videoViewProvider)
    @moduleProvider = moduleProvider
    @videoProvider = videoViewProvider
  end

  def get_videos_by_month(user)
    views = @videoProvider.get_views_by_month(user, @moduleProvider.get_start_date, @moduleProvider.get_end_date)
    start_date = Date.parse(@moduleProvider.get_start_date)
    end_date = Date.parse(@moduleProvider.get_end_date)
    date_range = start_date..end_date
    date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
    formatted_views = {}
    views.each do |view|
      formatted_views[view.month] = view.total_views
    end
    @views_months = []
    date_months.each do |month|
      if formatted_views[month.month]
        views =  formatted_views[month.month]
      else
        views = 0
      end
      @views_months.push(views)
    end
    return @views_months
  end

  def get_videos_viewed(user)
    videosViewed = []
    @moduleProvider.get_all_videos.each do |video|
      videoView = @videoProvider.get_view(user, video['slug'])
      if videoView
        video['viewed'] = 'yes'
      else
        video['viewed'] = 'no'
      end
      videosViewed.push(video)
    end
    return videosViewed
  end
end
