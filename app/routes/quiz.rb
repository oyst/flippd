require_relative '../lib/quiz/resultProcessor'
require_relative '../lib/quiz/result'
require_relative '../lib/url/generator'

class Flippd < Sinatra::Application
  before do
    @quizProcessor = QuizResultProcessor.new
  end

  route :get, :post, '/topics/:title/questions' do
    @topic = nil
    @phases.each do |phase|
      phase['topics'].each do |topic|
        @topic = topic if UrlGenerator.to_url(topic['title']) == params['title']
      end
    end
    pass unless @topic
    @questions = @topic['questions']
    pass unless @questions
    @correct_questions = []
    if params['question']
      @answers = params['question']
      quizResult = @quizProcessor.get_result(@questions, @answers)
      @score = quizResult.score
      @correct_questions = quizResult.correctQuestions
    end
    erb :quiz
  end
end
