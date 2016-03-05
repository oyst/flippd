require_relative '../lib/dashboard/widgets/factories/quizWidget'
require_relative '../lib/dashboard/widgets/factories/videoGraphWidget'
require_relative '../lib/dashboard/widgets/factories/videoViewWidget'
require_relative '../lib/dashboard/dashboard.rb'

class Flippd < Sinatra::Application
  get '/dashboard' do
    redirect to('/auth/new') unless @user
    scores = @quiz_score_summary.get_score_summary(@user)
    quiz_table_widget = QuizWidget.create(scores)
    views = @video_summary.get_videos_by_month(@user)
    video_graph_widget = VideoGraphWidget.create(views)
    videos_viewed = @video_summary.get_videos_viewed(@user)
    video_view_widget = VideoViewWidget.create(videos_viewed)
    @dashboard = Dashboard.new
    @dashboard.add(quiz_table_widget)
    @dashboard.add(video_graph_widget)
    @dashboard.add(video_view_widget)
    erb :dashboard
  end
end
