class Flippd < Sinatra::Application
  get '/dashboard' do
    erb :dashboard
  end
end
