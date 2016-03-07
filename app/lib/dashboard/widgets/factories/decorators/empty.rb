class Empty
  def self.create(empty_message)
    return lambda { |value| if value.nil? then empty_message else value end}
  end
end
