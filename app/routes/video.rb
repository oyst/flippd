class Flippd < Sinatra::Application
  get '/videos/:id' do
    @video_data = @json_module_provider.get_video(params['id'])
    @phase = @video_data[:phase]
    @video = @video_data[:video]
    @comments = @comment_provider.get_comments(@video['slug'])
    @next_video = @json_module_provider.get_next_video(params['id'])
    @previous_video = @json_module_provider.get_previous_video(params['id'])

    if session['comment_error']
      @comment_error = session['comment_error']
      session['comment_error'] = nil
    end
    @user_has_viewed = true if @user and @video_view_provider.get_view(@user, @video['slug']) != nil
    @ratings = @json_module_provider.get_ratings
    @user_rating = @video_rating_provider.get_rating(@user, @video['slug'])
    pass unless @video
    erb :video
  end

  post '/video-view' do
    protected!
    video_id = params['video_id']
    @video_view_provider.add_view(@user, video_id)
    redirect back
  end

  post '/remove-video-view' do
    protected!
    video_id = params['video_id']
    @video_view_provider.remove_view(@user, video_id)
    redirect back
  end

  post '/video-rate' do
    protected!
    video_id = params['video_id']
    rating_id = params['rating_id']
    @video_rating_provider.add_rating(@user, video_id, rating_id)
    redirect back
  end
end
