require_relative '../lib/dashboard/widgets/factories/quizWidget'
require_relative '../lib/dashboard/widgets/factories/videoGraphWidget'
require_relative '../lib/dashboard/dashboard.rb'

class Flippd < Sinatra::Application
  get '/dashboard' do
    redirect to('/auth/new') unless @user
    scores = @quizScoreSummary.get_score_summary(@user)
    quizTableWidget = QuizWidget.create(scores)
    views = @videoSummary.get_videos_by_month(@user)
    videoGraphWidget = VideoGraphWidget.create(views)
    @dashboard = Dashboard.new
    @dashboard.add(quizTableWidget)
    @dashboard.add(videoGraphWidget)
    erb :dashboard
  end
end
