require_relative '../table/tableWidget.rb'
require_relative '../table/tableColumn.rb'
require_relative 'decorators/link'

class VideoViewCountWidget
  def self.create(data)
    video = TableColumn.new('Video', 'title')
    views = TableColumn.new('Views', 'views')
    link  = TableColumn.new('Link', 'id', Link.create('/videos/', 'Go to video'))
    columns = [video, views, link]
    TableWidget.new(columns, data, 'Video Views')
  end
end
