require_relative '../lib/dashboard/widgets/factories/quizWidget'
require_relative '../lib/dashboard/widgets/factories/videoGraphWidget'
require_relative '../lib/dashboard/dashboard.rb'

class Flippd < Sinatra::Application
  get '/dashboard' do
    redirect to('/auth/new') unless @user
    scores = @quizScoreSummary.get_score_summary(@user)
    quizTableWidget = QuizWidget.create(scores)
    videoGraphWidget = VideoGraphWidget.create([1,2,3,4,5,6,7,8,9])
    @dashboard = Dashboard.new
    @dashboard.add(quizTableWidget)
    @dashboard.add(videoGraphWidget)
    erb :dashboard
  end
end
