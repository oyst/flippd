class View
  include DataMapper::Resource

  property :id, Serial
  property :videoid, String, required: true, length: 100
  property :date, DateTime, required: true

  belongs_to :user
end
