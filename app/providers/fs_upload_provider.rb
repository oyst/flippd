require "digest/sha1"
require "fileutils"

class FileSystemUploadProvider 

  def initialize
    @publics = Dir.pwd + "/app/public"
    @upload_dir = "/uploads"
  end

  def upload(namespace, tmpfile, filename)
    # Create the namespace directories
    FileUtils.mkdir_p(get_abs_path(namespace, nil))
    File.open(get_abs_path(namespace, filename), "w") do |f|
      f.write(tmpfile.read)
    end
    filename
  end

  def get_relative_path(namespace, filename)
    "#{@upload_dir}/#{namespace}/#{filename}"
  end

  def get_abs_path(namespace, filename)
    @publics + get_relative_path(namespace, filename)
  end

  def exists?(namespace, filename)
    File.exists?(get_abs_path(namespace, filename))
  end

end
