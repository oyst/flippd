class JsonModuleProvider
  def initialize(module_json)
    @json = module_json
  end

  def get_video(video_id)
    @json['phases'].each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          if video["id"] == video_id.to_i
            @data = {:phase => phase, :video => video}
          end
        end
      end
    end
    return @data
  end

  def get_next_video(current_video_id)

  end

  def get_previous_video(current_video_id)

  end

  def get_videos(topic_slug)

  end
end
