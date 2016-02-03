class QuizResultProcessor
  
  def getResult(questions, submittedQuestions)
      correctQuestions = {}
      questions.each do |question|
        answerId = submittedQuestions["#{question['id']}"]
        if answerId == "#{question['correctAnswerId']}" then
          correctQuestions[question['id']] = true
        end
      end
      QuizResult.new(correctQuestions)
  end
end
