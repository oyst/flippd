require 'open-uri'
require 'json'
require_relative '../lib/quiz/quizScoreSummary'
require_relative '../lib/videos/videoSummary.rb'
require_relative '../lib/videos/overall/video_summary'
require_relative '../lib/profile/profile_image_storer'

class Flippd < Sinatra::Application
  LECTURER_ROLE_NAME = "lecturer"
  PTA_ROLE_NAME = "pta"
  before do
    # Load in the configuration (at the URL in the project's .env file)
    @comment_provider = DbCommentProvider.new
    @video_view_provider = VideoViewProvider.new
    @video_rating_provider = VideoRatingProvider.new
    @quiz_score_provider = QuizScoreProvider.new
    # The configuration doesn't have to include identifiers, so we
    # add an identifier to each phase and video
    module_data = JSON.load(open(ENV['CONFIG_URL'] + "module.json"))
    phase_id = 1
    video_id = 1
    module_data['phases'].each do |phase|
      phase["id"] = phase_id
      phase_id += 1

      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          video["id"] = video_id
          video_id += 1
        end
      end
    end
    @json_module_provider = JsonModuleProvider.new(module_data)
    @module_title = @json_module_provider.get_title
    @phases = @json_module_provider.get_phases
    @quiz_score_summary = QuizScoreSummary.new(@json_module_provider, @quiz_score_provider)
    @video_summary = VideoSummary.new(@json_module_provider, @video_view_provider)
    @overall_video_summary = OverallVideoSummary.new(@json_module_provider, @video_view_provider)
    @user_role_provider = UserRoleProvider.new(@json_module_provider)
    @user_provider = UserProvider.new
    @upload_provider = FileSystemUploadProvider.new
    @profile_image_storer = ProfileImageStorer.new(@upload_provider)
  end

  before '/lecturer/*' do
    authorized!(LECTURER_ROLE_NAME)
  end

  before '/pta/*' do
    authorized!(LECTURER_ROLE_NAME, PTA_ROLE_NAME)
  end

  helpers do
    def protected!
      redirect to('auth/new') unless @user
    end

    def authorized!(*roles)
      redirect to('auth/new') unless @user
      has_role = roles.any? { |role| @user_role_provider.has_role(@user, role) }
      halt(401, 'You are not authorized to view this page') unless has_role
    end

    def authorized?(*roles)
      roles.any? { |role| @user_role_provider.has_role(@user, role) }
    end

    def get_role
      @user_role_provider.get_role(@user)
    end
  end

  get '/' do
    erb open(ENV['CONFIG_URL'] + "index.erb").read
  end

  get '/phases/:title' do
    @phase = nil
    @phases.each do |phase|
      @phase = phase if phase['title'].downcase.gsub(" ", "_") == params['title']
    end

    pass unless @phase
    erb :phase
  end

end
