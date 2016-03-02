require_relative '../graph/graphWidget.rb'

class VideoGraphWidget
  def self.create(data)
    GraphWidget.new(data, 'Videos Watched Graph')
  end
end
