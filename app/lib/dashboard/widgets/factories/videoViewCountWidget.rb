require_relative '../table/tableWidget.rb'
require_relative '../table/tableColumn.rb'

class VideoViewCountWidget
  def self.create(data)
    video = TableColumn.new('Video', 'title')
    views = TableColumn.new('Views', 'views')
    id_to_link = Proc.new { |id| "<a href='/videos/" + id.to_s  + "'>Go to video</a>" }
    link  = TableColumn.new('Link', 'id', '', id_to_link)
    columns = [video, views, link]
    TableWidget.new(columns, data, 'Video Views')
  end
end
