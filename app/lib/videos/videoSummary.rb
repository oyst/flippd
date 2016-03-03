require 'date'

class VideoSummary
  def initialize(moduleData, videoViewProvider)
    @moduleData = moduleData
    @videoProvider = videoViewProvider
  end

  def get_videos_by_month(user)
    views = @videoProvider.get_views_by_month(user, @moduleData['startDate'], @moduleData['endDate'])
    start_date = Date.parse(@moduleData['startDate'])
    end_date = Date.parse(@moduleData['endDate'])
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
end
