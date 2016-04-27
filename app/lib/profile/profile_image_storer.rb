class ProfileImageStorer
  def initialize(upload_provider)
    @upload_provider = upload_provider
    @namespace = 'profile_image'
  end

  def store(tmp, user)
    @upload_provider.upload(@namespace, tmp, user.id)
  end

  def get_src(user)
    @upload_provider.get_relative_path(@namespace, user.id) if @upload_provider.exists?(@namespace, user.id)
  end
end
