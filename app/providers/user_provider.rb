class UserProvider
  def get_user_by_id(user_id)
    User.first(:id => user_id)
  end

  def get_all_users
    User.all
  end
end
