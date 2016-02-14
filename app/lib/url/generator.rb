class UrlGenerator

  def self.to_url(string)
    string.downcase.gsub(" ", "_")
  end

end
