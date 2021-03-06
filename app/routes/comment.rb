class Flippd < Sinatra::Application
  post '/comments' do
    protected!
    user_id   = session[:user_id]
    message   = params['message']
    video_id  = params['video_id']
    if message.empty?
      session['comment_error'] = 'Please enter valid comment'
      redirect back
    end
    parent_id = params['parent_id']
    @comment_provider.create(user_id, message, video_id, parent_id)
    redirect back
  end
end
