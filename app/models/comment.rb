class Comment
  include DataMapper::Resource

  property :id, Serial
  property :text, String, required: true, length: 1024
  property :videoid, String, required: true, length: 100
  property :date, DateTime, required: true

  has n, :comments
  belongs_to :comment, required: false
  belongs_to :user
end
