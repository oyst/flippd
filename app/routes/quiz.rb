class Flippd < Sinatra::Application
  route :get, :post, '/topics/:title/questions' do
    @topic = nil
    @phases.each do |phase|
      phase['topics'].each do |topic|
        @topic = topic if topic['title'].downcase.gsub(" ", "_") == params['title']
      end
    end
    @questions = @topic['questions']
    pass unless @questions
    if params['question']
      @score = 0
      @questions.each do |question|
        answerId = params['question']["#{question['id']}"]
        if answerId == "#{question['correctAnswerId']}" then
          @score += 1
        end
      end
      @answers = params['question']
    end
    erb :quiz
  end
end
