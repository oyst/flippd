class Flippd < Sinatra::Application
  route :get, :post, '/topics/:title/questions' do
    if params['question']
      @score = 0
      params['question'].each do |answer|
        if answer == 'true'
          @score += 1
        end
      end
    end
    @topic = nil
    @phases.each do |phase|
      phase['topics'].each do |topic|
        @topic = topic if topic['title'].downcase.gsub(" ", "_") == params['title']
      end
    end
    @questions = @topic['questions']
    pass unless @questions
    erb :quiz
  end
end
