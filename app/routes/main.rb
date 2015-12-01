require 'open-uri'
require 'json'

class Flippd < Sinatra::Application
  before do
    # Load in the configuration (at the URL in the project's .env file)
    @module = JSON.load(open(ENV['CONFIG_URL'] + "module.json"))
    @phases = @module['phases']

    # The configuration doesn't have to include identifiers, so we
    # add an identifier to each phase and video
    phase_id = 1
    video_id = 1
    @phases.each do |phase|
      phase["id"] = phase_id
      phase_id += 1

      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          video["id"] = video_id
          video_id += 1
        end
      end
    end
  end

  post '/comments' do
    unless session[:user_id]
      redirect to('/auth/new')
    end
    user_id   = session[:user_id]
    message   = params['message']
    video_id  = params['video_id']
    if message.empty?
      session['comment_error'] = 'Please enter valid comment'
      redirect back
    end
    parent_id = params['parent_id']
    CommentProvider.create(user_id, message, video_id, parent_id)
    redirect back
  end

  get '/' do
    erb open(ENV['CONFIG_URL'] + "index.erb").read
  end

  get '/phases/:title' do
    @phase = nil
    @phases.each do |phase|
      @phase = phase if phase['title'].downcase.gsub(" ", "_") == params['title']
    end

    pass unless @phase
    erb :phase
  end

  get '/videos/:id' do
    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          if video["id"] == params['id'].to_i
            @phase = phase
            @video = video
            @comments = CommentProvider.get_comments(@video['slug'], 0, 10, nil)
          end
        end
      end
    end

    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          if video["id"] == params['id'].to_i + 1
            @next_video = video
          end
        end
      end
    end

    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          if video["id"] == params['id'].to_i - 1
            @previous_video = video
          end
        end
      end
    end

    if session['comment_error']
      @comment_error = session['comment_error']
      session['comment_error'] = nil
    end

    pass unless @video
    #@video['comments'][0]
    erb :video
  end
end
