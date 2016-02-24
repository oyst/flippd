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
    @correctQuestions = {}
    if params['question']
      @answers = params['question']
      quizResult = @quizProcessor.getResult(@questions, @answers)
      @score = quizResult.score
      @correctQuestions = quizResult.correctQuestions
    end
    erb :quiz
  end
end
