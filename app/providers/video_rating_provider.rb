class VideoRatingProvider
  def add_rating(user, video_id, rating_name)
    user_rating = UserRating.first_or_create({:videoid => video_id, :user => user}, {:rating_name => rating_name, :date => Time.now})
    user_rating.rating_name = rating_name
    user_rating.save
  end

  def get_rating(user, video_id)
    UserRating.first(:user => user, :videoid => video_id)
  end
end
