class QuizResult
  attr_reader :correctQuestions
  def initialize(correctQuestions)
    @correctQuestions = correctQuestions
  end

  def getScore
    @correctQuestions.length
  end

end
