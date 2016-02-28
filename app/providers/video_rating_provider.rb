class VideoRatingProvider
  def add_rating(user, video_id, rating_id)
    rating = Rating.get(rating_id)
    return nil if rating == nil
    UserRating.create(:videoid => video_id, :user => user, :rating => rating, :date => Time.now)
  end

  def get_rating(user, video_id)
    UserRating.first(:user => user, :videoid => video_id)
  end

  def get_ratings()
    Rating.all()
  end

end
