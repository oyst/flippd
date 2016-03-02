require_relative '../tableWidget.rb'
class QuizWidget

  def self.create(data)
    headings = ['Topic', 'Score']
    keys = ['title', 'score']
    empties = {'score' => 'Not yet taken'}
    TableWidget.new(headings, keys, empties, data)
  end
end
