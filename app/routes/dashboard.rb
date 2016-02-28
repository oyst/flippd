class Flippd < Sinatra::Application
  get '/dashboard' do
    erb :dashboard
  end
  post '/video-view' do
    redirect to('/auth/new') if @user == nil
    video_id = params['video_id']
    @videoViewProvider.add_view(@user, video_id)
    redirect back
  end
end
