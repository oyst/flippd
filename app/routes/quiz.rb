require_relative '../lib/quiz/resultProcessor'
require_relative '../lib/quiz/result'

class Flippd < Sinatra::Application
  before do
    @quizProcessor = QuizResultProcessor.new
  end

  route :get, :post, '/topics/:title/questions' do
    @topic = nil
    @phases.each do |phase|
      phase['topics'].each do |topic|
        @topic = topic if topic['title'].downcase.gsub(" ", "_") == params['title']
      end
    end
    @questions = @topic['questions']
    pass unless @questions
    @correctQuestions = {}
    if params['question']
      quizResult = @quizProcessor.getResult(@questions, params['question'])
      @score = quizResult.score
      @correctQuestions = quizResult.correctQuestions
      @answers = params['question']
    end
    erb :quiz
  end
end
