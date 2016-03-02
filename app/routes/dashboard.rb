require_relative '../lib/dashboard/widgets/factories/quizWidget.rb'
require_relative '../lib/dashboard/dashboard.rb'

class Flippd < Sinatra::Application
  get '/dashboard' do
    redirect to('/auth/new') if @user == nil
    scores = @quizScoreSummary.get_score_summary(@user)
    quizTableWidget = QuizWidget.create(scores)
    @dashboard = Dashboard.new
    @dashboard.add(quizTableWidget)
    erb :dashboard
  end
end
