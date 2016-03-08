require "digest/sha1"
require "fileutils"

class FileSystemProvider 

  def initialize
    @publics = Dir.pwd + "/app/public"
    @upload_dir = "/uploads"
  end

  def upload(namespace, tmpfile, filename = nil)
    filename = Digest::SHA1.hexdigest(filename) unless filename
    # Create the namespace directories
    FileUtils.mkdir_p(get_full_path(namespace, nil))
    File.open(get_full_path(namespace, filename), "w") do |f|
      f.write(tmpfile.read)
    end
    filename
  end

  def retrieve_path(namespace, filename)
    "#{@upload_dir}/#{namespace}/#{filename}"
  end

  def get_full_path(namespace, filename)
    @publics + retrieve_path(namespace, filename)
  end

  def exists?(namespace, filename)
    File.exists?(get_full_path(namespace, filename))
  end

end
