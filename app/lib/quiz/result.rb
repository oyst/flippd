class QuizResult
  attr_reader :correctQuestions
  def initialize(correctQuestions)
    @correctQuestions = correctQuestions
  end

  def score
    @correctQuestions.length
  end

end
