class QuizScoreProvider
  def add_score(user, topic_id, score)
    QuizScore.create(:topic_id => topic_id, :user => user, :score => score, :date => Time.now)
  end
end
