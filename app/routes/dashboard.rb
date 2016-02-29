class Flippd < Sinatra::Application
  get '/dashboard' do
    redirect to('/auth/new') if @user == nil
    @topics = []
    @phases.each do |phase|
      phase['topics'].each do |topic|
        topScore = @quizScoreProvider.get_highest_score(@user, topic['slug'])
        topic['score'] = topScore
        @topics.push(topic)
      end
    end
    erb :dashboard
  end

  post '/video-view' do
    redirect to('/auth/new') if @user == nil
    video_id = params['video_id']
    @videoViewProvider.add_view(@user, video_id)
    redirect back
  end

  post '/remove-video-view' do
    redirect to('auth/new') if @user == nil
    video_id = params['video_id']
    @videoViewProvider.remove_view(@user, video_id)
    redirect back
  end
  post '/video-rate' do
    redirect to('/auth/new') if @user == nil
    video_id = params['video_id']
    rating_id = params['rating_id']
    @videoRatingProvider.add_rating(@user, video_id, rating_id)
    redirect back
  end
end
