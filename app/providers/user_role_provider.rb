class UserRoleProvider
  def initialize(module_provider)
    @module_provider = module_provider
  end

  def has_role(user, role)
    users = @module_provider.get_users_by_role(role)
    users.include?(user.email)
  end

  def get_role(user)
      role_data = @module_provider.get_user_roles.find { |role| role['users'].include? user.email }
      return unless role_data
      role_data['name']
  end
end
