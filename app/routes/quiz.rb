require_relative '../lib/quiz/resultProcessor'
require_relative '../lib/quiz/result'

class Flippd < Sinatra::Application
  before do
    @quiz_processor = QuizResultProcessor.new
  end

  route :get, :post, '/topics/:title/questions' do
    redirect to('auth/new') unless @user
    @topic = @json_module_provider.get_topic(params['title'])
    pass unless @topic
    @questions = @topic['questions']
    pass unless @questions
    @correct_questions = {}
    if params['question']
      @answers = params['question']
      quiz_result = @quiz_processor.get_result(@questions, @answers)
      @score = quiz_result.score
      @correct_questions = quiz_result.correct_questions
      @quiz_score_provider.add_score(@user, @topic['slug'], @score)
    end
    @previous_scores = @quiz_score_provider.get_scores(@user, @topic['slug'])
    erb :quiz
  end
end
