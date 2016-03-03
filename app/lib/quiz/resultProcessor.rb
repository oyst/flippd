class QuizResultProcessor

  def get_result(questions, submitted_questions)
      correct_questions = {}
      questions.each do |question|
        answer_id = submitted_questions[question['id'].to_s]
        if answer_id == question['correctAnswerId'].to_s then
          correct_questions[question['id']] = true
        end
      end
      QuizResult.new(correct_questions)
  end
end
