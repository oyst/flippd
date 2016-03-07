require_relative '../table/tableWidget.rb'
require_relative '../table/tableColumn.rb'
class VideoViewWidget
  def self.create(data)
    video  = TableColumn.new('Video', 'title')
    viewed = TableColumn.new('Viewed', 'viewed', lambda { |bool| bool ? 'yes' : 'no' })
    columns = [video, viewed]
    TableWidget.new(columns, data, 'My Videos')
  end
end
