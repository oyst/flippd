class QuizScoreSummary
  def initialize(module_provider, quiz_score_provider)
    @module_provider = module_provider
    @quiz_score_provider = quiz_score_provider
  end

  def get_score_summary(user)
    topics = []
    @module_provider.get_all_topics.each do |topic|
        next unless topic['questions']
        topScore = @quiz_score_provider.get_highest_score(user, topic['slug'])
        topic['score'] = topScore
        topics.push(topic)
    end
    return topics
  end
end
