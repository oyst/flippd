class GraphWidget
  attr_reader :data, :title, :template
  def initialize(data, title)
    @data     = data
    @title    = title
    @template = :"widgets/graph"
  end
end
