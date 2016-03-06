require_relative '../lib/url/generator'

class JsonModuleProvider
  def initialize(module_json)
    @json   = module_json
    @phases = @json['phases']
  end

  def get_video(video_id)
    videos = get_all_videos
    videos.select { |video| video['id'] == video_id.to_i }.first
  end

  def get_next_video(current_video_id)
    videos = get_all_videos
    videos.select { |video| video['id'] == current_video_id.to_i + 1 }.first
  end

  def get_previous_video(current_video_id)
    videos = get_all_videos
    videos.select { |video| video['id'] == current_video_id.to_i - 1 }.first
  end

  def get_all_videos
    videos = []
    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          video['phase'] = phase
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
    topics = get_all_topics
    topics.select { |topic|  UrlGenerator.to_url(topic['title']) == url_title }.first
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

  def get_users_by_role(user_role)
    role_data = @json['user_roles'].select { |role| role['name'] == user_role }.first
    role_data['users']
  end
end
