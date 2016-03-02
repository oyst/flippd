require_relative '../graph/graphWidget.rb'

class VideoGraphWidget
  def self.create(data)
    labels = ['October', 'November', 'December', 'January', 'February', 'March', 'April', 'May', 'June']
    GraphWidget.new(labels, data, 'Videos Watched Graph')
  end
end
