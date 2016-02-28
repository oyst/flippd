class QuizScore
  include DataMapper::Resource

  property :id, Serial
  property :topic_id, String, required: true, length: 100
  property :score, Integer, required: true
  property :date, DateTime, required: true

  belongs_to :user
end
