require 'open-uri'
require 'json'
require_relative '../lib/quiz/quizScoreSummary'
require_relative '../lib/videos/videoSummary.rb'

class Flippd < Sinatra::Application
  before do
    # Load in the configuration (at the URL in the project's .env file)
    @module = JSON.load(open(ENV['CONFIG_URL'] + "module.json"))
    @phases = @module['phases']
    @commentProvider = DbCommentProvider.new
    @videoViewProvider = VideoViewProvider.new
    @videoRatingProvider = VideoRatingProvider.new
    @quizScoreProvider = QuizScoreProvider.new
    @jsonModuleProvider = JsonModuleProvider.new(@module)
    @quizScoreSummary = QuizScoreSummary.new(@phases, @quizScoreProvider)
    @videoSummary = VideoSummary.new(@module, @videoViewProvider)

    # The configuration doesn't have to include identifiers, so we
    # add an identifier to each phase and video
    phase_id = 1
    video_id = 1
    @phases.each do |phase|
      phase["id"] = phase_id
      phase_id += 1

      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          video["id"] = video_id
          video_id += 1
        end
      end
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
