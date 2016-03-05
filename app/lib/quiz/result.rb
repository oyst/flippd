class QuizResult
  attr_reader :correct_questions
  def initialize(correct_questions)
    @correct_questions = correct_questions
  end

  def score
    @correct_questions.length
  end

end
