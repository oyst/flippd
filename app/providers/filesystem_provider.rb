require "digest/sha1"

class FileSystemProvider 
  @upload_dir = "uploads"

  def upload(namespace, tmpfile, filename = nil)
    filename = Digest::SHA1.hexdigest(filename) unless filename
    File.open("#{@upload_dir}/#{namespace}/#{filename}", "w") do |f|
      f.write(tmpfile.read)
    end
    filename
  end

  def retrieve_path(namespace, filename)
    "#{@upload_dir}/#{namespace}/#{filename}"
  end

  def exists?(namespace, filename)
    File.exists?("#{@upload_dir}/#{namespace}/#{filename}")
  end

end
