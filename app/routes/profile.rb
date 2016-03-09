class Flippd < Sinatra::Application
  get '/profile' do
    protected!
    erb :profile, :locals => {:img_src => @profile_image_storer.get_src(@user)}
  end

  post '/profile/upload' do
    protected!
    temp = params['file'][:tempfile]
    @profile_image_storer.store(temp, @user)
    return "File uploaded"
  end
end
