class Link
  def self.create(page, link_name)
    return lambda { |id| "<a href='#{page}#{id}'>#{link_name}</a>" }
  end
end
