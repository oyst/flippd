require_relative '../lib/dashboard/widgets/factories/quizWidget'
require_relative '../lib/dashboard/widgets/factories/videoGraphWidget'
require_relative '../lib/dashboard/widgets/factories/videoViewWidget'
require_relative '../lib/dashboard/widgets/factories/videoViewCountWidget.rb'
require_relative '../lib/dashboard/widgets/factories/userTableWidget'
require_relative '../lib/dashboard/dashboard.rb'

class Flippd < Sinatra::Application
  get '/dashboard/?:id?' do
    protected!
    user = @user
    if params['id']
      authorized!(LECTURER_ROLE_NAME)
      user = @user_provider.get_user_by_id(params['id'])
    end
    pass unless user

    scores = @quiz_score_summary.get_score_summary(user)
    quiz_table_widget = QuizWidget.create(scores)
    views = @video_summary.get_videos_by_month(user)
    video_graph_widget = VideoGraphWidget.create(views)
    videos_viewed = @video_summary.get_videos_viewed(user)
    video_view_widget = VideoViewWidget.create(videos_viewed)
    @dashboard = Dashboard.new
    @dashboard.add(quiz_table_widget)
    @dashboard.add(video_graph_widget)
    @dashboard.add(video_view_widget)
    erb :dashboard
  end

  get '/lecturer/dashboard' do
    overall_views = @overall_video_summary.get_views_per_video()
    video_views_widget = VideoViewCountWidget.create(overall_views)
    users = @user_provider.get_all_users
    user_table_widget = UserTableWidget.create(users)
    @dashboard = Dashboard.new
    @dashboard.add(user_table_widget)
    @dashboard.add(video_views_widget)
    erb :dashboard
  end

  get '/pta/dashboard' do
    views = @video_summary.get_videos_by_month(@user)
    video_graph_widget = VideoGraphWidget.create(views)
    @dashboard = Dashboard.new
    @dashboard.add(video_graph_widget)
    erb :dashboard
  end
end
