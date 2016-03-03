require_relative '../lib/url/generator'

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

  def get_all_videos
    videos = []
    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          videos.push(video)
        end
      end
    end
    return videos
  end

  def get_all_topics
    topics = []
    @phases.each do |phase|
      phase['topics'].each do |topic|
        topics.push(topic)
      end
    end
    return topics
  end

  def get_topic(url_title)
    selected_topic = nil
    @phases.each do |phase|
      phase['topics'].each do |topic|
        selected_topic = topic if UrlGenerator.to_url(topic['title']) == url_title 
      end
    end
    return selected_topic
  end

  def get_start_date
    @json['startDate']
  end

  def get_end_date
    @json['endDate']
  end

  def get_ratings
    @json['ratings']
  end

  def get_title
    @json['title']
  end

  def get_phases
    @json['phases']
  end
end
