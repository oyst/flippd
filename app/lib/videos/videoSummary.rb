require 'date'

class VideoSummary
  def initialize(module_provider, video_view_provider)
    @module_provider = module_provider
    @video_provider = video_view_provider
  end

  def get_videos_by_month(user)
    # Create a list of months from start_date to end_date
    # Assumes that there will be only one occurance of each month
    start_date = Date.parse(@module_provider.get_start_date)
    end_date = Date.parse(@module_provider.get_end_date)
    date_range = start_date..end_date
    date_months = date_range.map {|d| d.month }.uniq
    @views_months = {}
    date_months.each do |month|
      @views_months[month] = @video_provider.get_views_by_month(user, month, start_date, end_date) or 0
    end
    @views_months
  end

  def get_videos_viewed(user)
    videos_viewed = []
    @module_provider.get_all_videos.each do |video|
      video_view = @video_provider.get_view(user, video['slug'])
      if video_view
        video['viewed'] = 'yes'
      else
        video['viewed'] = 'no'
      end
      videos_viewed.push(video)
    end
    return videos_viewed
  end
end
