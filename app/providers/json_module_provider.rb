class JsonModuleProvider
  def initialize(module_json)
    @json   = module_json
    @phases = @json['phases']
  end

  def get_video(video_id)
    @phases.each do |phase|
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
    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          if video["id"] == current_video_id.to_i + 1
            @next_video = video
          end
        end
      end
    end
    return @next_video
  end

  def get_previous_video(current_video_id)
    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          if video["id"] == current_video_id.to_i - 1
            @previous_video = video
          end
        end
      end
    end
    return @previous_video
  end

  def get_videos(topic_slug)

  end
end
