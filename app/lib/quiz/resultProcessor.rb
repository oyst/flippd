class QuizResultProcessor

  def get_result(questions, submitted_questions)
    correct_questions = questions.select { |question| submitted_questions[question['id'].to_s] == question['correctAnswerId'].to_s }
    correct_questions = correct_questions.map { |question| question['id'] }
    QuizResult.new(correct_questions)
  end
end
