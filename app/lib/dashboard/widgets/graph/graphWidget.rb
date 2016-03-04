class GraphWidget
  attr_reader :data_points, :title, :template
  def initialize(data_points, title)
    @data_points = data_points
    @title       = title
    @template    = :"widgets/graph"
  end
end
