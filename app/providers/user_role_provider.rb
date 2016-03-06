class UserRoleProvider
  def initialize(module_provider)
    @module_provider = module_provider
  end

  def has_role(user, role)
    users = @module_provider.get_users_by_role(role)
    users.include?(user.email)
  end

end
