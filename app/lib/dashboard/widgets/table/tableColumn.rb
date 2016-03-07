class TableColumn
  attr_reader :heading, :key, :empty_message, :decorator
  def initialize(heading, key, empty_message = nil, decorator = lambda { |value| value })
    @heading = heading
    @key = key
    @empty_message = empty_message
    @decorator = decorator
  end

  def get_cell(data)
    value = data[@key]
    return @empty_message if value.nil?
    value = @decorator.call(value)
  end
end
