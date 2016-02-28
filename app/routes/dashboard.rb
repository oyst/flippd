class Flippd < Sinatra::Application
  get '/dashboard' do
    erb :dashboard
  end
  post '/video-view' do
    redirect to('/auth/new') if @user == nil
    video_id = params['video_id']
    View.create(:videoid => video_id, :user => @user, :date => Time.now)
    redirect back
  end
end
