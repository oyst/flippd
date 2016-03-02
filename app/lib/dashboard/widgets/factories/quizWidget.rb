require_relative '../table/tableWidget.rb'
require_relative '../table/tableColumn.rb'
class QuizWidget

  def self.create(data)
    topic = TableColumn.new('Topic', 'title')
    score = TableColumn.new('Score', 'score', 'Not yet taken')
    columns = [topic, score]
    TableWidget.new(columns, data)
  end
end
