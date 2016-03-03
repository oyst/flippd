class Flippd < Sinatra::Application
  get '/videos/:id' do
    @videoData = @jsonModuleProvider.get_video(params['id'])
    @phase = @videoData[:phase]
    @video = @videoData[:video]
    @comments = @commentProvider.get_comments(@video['slug'])

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
    @user_has_viewed = true if @user and @videoViewProvider.get_view(@user, @video['slug']) != nil
    @ratings = @module['ratings']
    @user_rating = @videoRatingProvider.get_rating(@user, @video['slug'])
    pass unless @video
    erb :video
  end

  post '/video-view' do
    redirect to('/auth/new') unless @user
    video_id = params['video_id']
    @videoViewProvider.add_view(@user, video_id)
    redirect back
  end

  post '/remove-video-view' do
    redirect to('auth/new') unless @user
    video_id = params['video_id']
    @videoViewProvider.remove_view(@user, video_id)
    redirect back
  end

  post '/video-rate' do
    redirect to('/auth/new') unless @user
    video_id = params['video_id']
    rating_id = params['rating_id']
    @videoRatingProvider.add_rating(@user, video_id, rating_id)
    redirect back
  end
end
