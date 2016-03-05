class UserRoleProvider
  def initialize(module_provider)
    @module_provider = module_provider
  end

  def has_role(user, role)
    has_role = false;
    users = @module_provider.get_users_by_role(role)
    users.each do |email|
      has_role = true if email == user.email
    end
    has_role
  end

end
