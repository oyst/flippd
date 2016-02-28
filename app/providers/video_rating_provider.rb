class VideoRatingProvider
  def add_rating(user, video_id, rating_id)
    rating = Rating.get(rating_id)
    return nil if rating == nil
    user_rating = UserRating.first_or_create({:videoid => video_id, :user => user}, {:rating => rating, :date => Time.now})
    user_rating.rating = rating
    user_rating.save
  end

  def get_rating(user, video_id)
    UserRating.first(:user => user, :videoid => video_id)
  end

  def get_ratings()
    Rating.all()
  end

end
