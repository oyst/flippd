class TableColumn
  attr_reader :heading, :key, :decorator
  def initialize(heading, key, decorator = lambda { |value| value })
    @heading = heading
    @key = key
    @decorator = decorator
  end

  def get_cell(data)
    value = data[@key]
    value = @decorator.call(value)
  end
end
