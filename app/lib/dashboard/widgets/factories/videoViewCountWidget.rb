require_relative '../table/tableWidget.rb'
require_relative '../table/tableColumn.rb'

class VideoViewCountWidget
  def self.create(data)
    video = TableColumn.new('Video', 'title')
    views = TableColumn.new('Views', 'views', 'No Views Yet')
    columns = [video, views]
    TableWidget.new(columns, data, 'Video Views')
  end
end
