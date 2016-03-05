require_relative '../graph/graphWidget.rb'
require_relative '../graph/dataPoint'

class VideoGraphWidget
  def self.create(data)
    data_points = []
    data.each do |month, value|
      data_points.push(DataPoint.new(Date::MONTHNAMES[month], value))
    end
    GraphWidget.new(data_points, 'Videos Watched Graph')
  end
end
