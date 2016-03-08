class Flippd < Sinatra::Application
  get '/profile' do
    protected!
    erb :profile
  end

  post '/profile/upload' do
    protected!
    temp = params['file'][:tempfile]
    filename = @user.id
    @file_provider.upload('profile_image', temp, filename)
    return "File uploaded"
  end
end
