class TableColumn
  attr_reader :heading, :key, :empty_message
  def initialize(heading, key, empty_message = nil)
    @heading = heading
    @key = key
    @empty_message = empty_message
  end
end
