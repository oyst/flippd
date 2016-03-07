require_relative '../table/tableWidget.rb'
require_relative '../table/tableColumn.rb'
class VideoViewWidget
  def self.create(data)
    video  = TableColumn.new('Video', 'title')
    bool_to_answer = lambda { |bool| if bool then 'yes' else 'no' end }
    viewed = TableColumn.new('Viewed', 'viewed', '', bool_to_answer)
    columns = [video, viewed]
    TableWidget.new(columns, data, 'My Videos')
  end
end
