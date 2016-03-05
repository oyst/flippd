class Dashboard
  attr_reader :widgets

  def initialize()
    @widgets = []
  end

  def add(widget)
    @widgets.push(widget)
  end
end
