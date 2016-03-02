class QuizScoreSummary
  def initialize(phases, quizScoreProvider)
    @phases = phases
    @quizScoreProvider = quizScoreProvider
  end

  def get_score_summary(user)
    topics = []
    @phases.each do |phase|
      phase['topics'].each do |topic|
        next unless topic['questions']
        topScore = @quizScoreProvider.get_highest_score(user, topic['slug'])
        topic['score'] = topScore
        topics.push(topic)
      end
    end
    return topics
  end
end
