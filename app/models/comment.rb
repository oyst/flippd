class Comment
  include DataMapper::Resource

  property :id, Serial
  property :text, String, required: true, length: 150
  property :user_id, Integer, required: true
  property :video_id, String, required: true, length: 30
  property :date, String, required: true, length: 150
end
