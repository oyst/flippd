class QuizResultProcessor
  
  def getResult(questions, submittedQuestions)
      correctQuestions = {}
      questions.each do |question|
        answerId = submittedQuestions[question['id'].to_s]
        if answerId == question['correctAnswerId'].to_s then
          correctQuestions[question['id']] = true
        end
      end
      QuizResult.new(correctQuestions)
  end
end
