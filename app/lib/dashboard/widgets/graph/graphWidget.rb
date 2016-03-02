class GraphWidget
  attr_reader :labels, :data, :title, :template
  def initialize(labels, data, title)
    @data     = data
    @title    = title
    @labels   = labels
    @template = :"widgets/graph"
  end
end
