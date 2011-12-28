require_dependency File.expand_path('../../user', __FILE__)

module User::Roles
  def admin?
    roles.include?(:admin)
  end

  def add_role(role)
    if roles.exclude?(role.to_sym)
      roles << role.to_sym
    end
  end
end
