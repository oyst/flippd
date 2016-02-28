class Rating
  include DataMapper::Resource
  property :id, Serial
  property :name, String, required: true, length: 100
  property :symbol, String, required: true, length: 10

  has n, :user_rating
end
