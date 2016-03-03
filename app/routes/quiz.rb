require_relative '../lib/quiz/resultProcessor'
require_relative '../lib/quiz/result'

class Flippd < Sinatra::Application
  before do
    @quizProcessor = QuizResultProcessor.new
  end

  route :get, :post, '/topics/:title/questions' do
    redirect to('auth/new') unless @user
    @topic = @jsonModuleProvider.get_topic(params['title'])
    pass unless @topic
    @questions = @topic['questions']
    pass unless @questions
    @correctQuestions = {}
    if params['question']
      @answers = params['question']
      quizResult = @quizProcessor.getResult(@questions, @answers)
      @score = quizResult.score
      @correctQuestions = quizResult.correctQuestions
      @quizScoreProvider.add_score(@user, @topic['slug'], @score)
    end
    @previousScores = @quizScoreProvider.get_scores(@user, @topic['slug'])
    erb :quiz
  end
end
