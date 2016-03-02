class TableWidget
  attr_reader :headings, :keys, :empties, :data, :template
  def initialize(headings, keys, empties, data)
    @headings = headings
    @keys     = keys
    @empties  = empties
    @data     = data
    @template = :"widgets/table"
  end
end
