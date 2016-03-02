class TableWidget
  attr_reader :columns, :data, :template
  def initialize(columns, data)
    @columns  = columns
    @data     = data
    @template = :"widgets/table"
  end
end
