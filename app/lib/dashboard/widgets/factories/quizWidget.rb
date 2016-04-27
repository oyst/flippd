require_relative '../table/tableWidget'
require_relative '../table/tableColumn'
require_relative 'decorators/placeholder'
class QuizWidget

  def self.create(data)
    topic = TableColumn.new('Topic', 'title')
    score = TableColumn.new('Score', 'score', Placeholder.create('Not yet taken'))
    columns = [topic, score]
    TableWidget.new(columns, data, 'My Quiz Scores')
  end
end
