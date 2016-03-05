class TableWidget
  attr_reader :columns, :data, :title, :template
  def initialize(columns, data, title)
    @columns  = columns
    @data     = data
    @title    = title
    @template = :"widgets/table"
  end
end
